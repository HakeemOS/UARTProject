----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 02:39:57 PM
-- Design Name: 
-- Module Name: startDetect_Rx - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity startDetect_Rx is
    port (  clk : in std_logic; 
            TxData : in std_logic;
            readingFlag : in std_logic; 
            rst : in std_logic;
            startRead : out std_logic 
    );
end startDetect_Rx;

architecture Behavioral of startDetect_Rx is

constant baudRate : integer := 19200; 
constant clkRate : integer := 50000000;
constant MaxClkCycles : integer := 6; 
constant startCount : integer := MaxClkCycles / 2; 

signal startRead_t : std_logic := '0'; 
signal sDetected : integer range 0 to startCount := 0; 

begin
    proc1 : process( clk, TxData, rst )
    begin
        if (rst = '1') then
            startRead_t <= '0'; 
            sDetected <= 0; 
        elsif (rising_edge(clk)) then
            startRead_t <= '0'; 
            if (sDetected = startCount-1) then
                startRead_t <= '1';  
                sDetected <= 0; 
            elsif (readingFlag = '1') then
                sDetected <= 0;
            elsif (TxData = '1') then
                sDetected <= 0; 
            elsif (TxData = '0' and readingFlag = '0') then
                sDetected <= sDetected + 1; 
            end if ;
        end if ;
    end process ; -- proc1

    startRead <= startRead_t; 

end Behavioral;
