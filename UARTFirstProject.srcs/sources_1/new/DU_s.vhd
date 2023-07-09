----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 05:33:04 PM
-- Design Name: 
-- Module Name: DU_s - Behavioral
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

entity DU_s is
    generic (N : integer  := 8 ); 
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic; 
            shiftData : in std_logic; 
            clk : in std_logic; 
            rst : in std_logic; 
            data : in std_logic_vector (N-1 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    );

end DU_s;

architecture Behavioral of DU_s is

constant MaxBits : integer := N + 2; 

signal serialOUT_t : std_logic := '0'; 
signal shiftDone_t : std_logic := '0';
signal zeroSig : std_logic := '0'; 
signal oneSig : std_logic := '1'; 
signal setFlag : std_logic := '0';    
signal dataPKT : std_logic_vector (N+1 downto 0) := (others => '1');  
signal tempPKT : std_logic_vector (N+1 downto 0) := (others => '0');    
signal shiftCnt : integer := 0;       
            

begin
    proc1 : process( clk )
    begin
        if (rst = '1') then
            dataPKT <= (others => '1'); 
            tempPKT <= (others => '0'); 
        elsif (rising_edge(clk)) then
            if(shiftCnt = MaxBits) then
                shiftDone_t <= '1'; 
                shiftCnt <= 0; 
                setFlag <= '0'; 
            elsif (shiftFlag = '1') then
                if (shiftData = '1') then
                    nShRegO(zeroSig, clk, oneSig, tempPKT, serialOUT_t, dataPKT); 
                    shiftCnt <= shiftCnt + 1; 
                    setFlag <= '1'; 
                elsif (setFlag = '1') then
                    tempPKT <= dataPKT; 
                    setFlag <= '0'; 
                end if ;
            elsif (loadFlag = '1') then
                dataPKT <= '1' & data & '0'; 
                tempPKT <= '1' & data & '0';  
                shiftDone_t <= '0'; 
            end if ;
        end if ;
    end process ; -- proc1

    shiftDone <= shiftDone_t; 
    serialOUT <= serialOUT_t; 

end Behavioral;
