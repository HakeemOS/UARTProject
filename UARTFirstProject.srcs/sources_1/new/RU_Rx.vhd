----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2023 07:34:56 PM
-- Design Name: 
-- Module Name: RU_Rx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library myLib; 
use myLib.paraPcr_p.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RU_Rx is
    generic (N : integer := 8); 
    port (  clk : in std_logic;
            startRead : in std_logic; 
            readFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            data : out std_logic_vector (N-1 downto 0) 
    );
end RU_Rx;

architecture Behavioral of RU_Rx is

constant MaxBits : integer := N+2; 

signal doneRead_t : std_logic := '0'; 
signal validated_t : std_logic := '0';
signal reading : std_logic := '0'; 
signal setFlag : std_logic := '0'; 
signal zeroSig : std_logic := '0'; 
signal data_t : std_logic_vector (N-1 downto 0) := (others => '0'); 
signal dataPKT : std_logic_vector (N+1 downto 0) := (others => '0'); 
signal tempPKT : std_logic_vector (N+1 downto 0) := (others => '1');  
signal readCount : integer := 0; 

begin

    proc1 : process( clk, startRead, readFlag, rst )
    begin
        if (rst = '1') then
            reading <= '0'; 
            doneRead_t <= '0';
            validated_t <= '0'; 
            data_t <= '0'; 
            setFlag <= '0'; 
            readCount <= 0; 
        elsif (rising_edge(clk)) then         
            if (startRead = '1') then
                reading <= '1'; 
            elsif (reading = '1') then
                if (readCount = MaxBits) then
                    reading <= '0'; 
                    doneRead_t <= '1'; 
                    readCount <= '0'; 
                    setFlag <= '0'; 
                elsif (readFlag = '1') then
                    nShReg(zeroSig, clk, TxData, tempPKT, dataPKT);
                    setFlag <= '1'; 
                    readCount <= readCount + 1; 
                elsif (setFlag = '1') then
                    tempPKT <= dataPKT;  
                    setFlag <= '0';   
                end if ;
            elsif (doneRead_t = '1' and validated_t = '0') then
                if (dataPKT'high = '1' and dataPKT'low = '0') then
                    validated_t <= '1'; 
                    data_t <= dataPKT (N downto 1); 
                end if ;
            elsif (validated_t = '1') then
                validated_t <= '0'; 
                doneRead_t <= '0'; 
            end if; 
            
        end if ;
    end process ; -- proc1


    doneRead <= doneRead_t; 
    validated <= validated_t; 
    data <= data_t;
end Behavioral;
