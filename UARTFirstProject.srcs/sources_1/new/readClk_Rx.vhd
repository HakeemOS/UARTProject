----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2023 06:21:18 PM
-- Design Name: 
-- Module Name: readClk_Rx - Behavioral
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

entity readClk_Rx is
    port (  clk : in std_logic;     
            setupFlag : in std_logic; 
            rst : in std_logic; 
            startRead : out std_logic; 
            readFlag : out std_logic 
    );
end readClk_Rx;

architecture Behavioral of readClk_Rx is

constant baudRate : integer := 19200; 
constant clkRate : integer := 50000000; 
constant MaxRead : integer := 10; 
constant MaxClkCycles : integer := 4; 
constant FirstRead : integer := MaxClkCycles / 2; 

signal startRead_t : std_logic := '0'; 
signal readData : std_logic := '0'; 
signal reading : std_logic := '0'; 
signal readingFirst : std_logic := '0'; 
signal readCount : integer range 0 to MaxRead := 0; 
signal clkCount : integer range 0 to MaxClkCycles := 0; 


begin
    proc1 : process( clk, setupFlag, rst )
    begin
        if (rst = '1') then
            startRead_t <= '0'; 
            readData <= '0'; 
            reading <= '0'; 
            readCount <= 0; 
            clkCount <= 0; 
        elsif (rising_edge(clk)) then
            startRead_t <= '0';
            readData <= '0'; 
            if (setupFlag = '1') then
                readingFirst <= '1'; 
                startRead_t <= '1'; 
                clkCount <= clkCount + 1;  
            end if ;
            if (readCount = MaxRead) then
                readCount <= 0; 
                clkCount <= 0; 
                reading <= '0'; 
            elsif (readingFirst = '1') then
                if (clkCount = FirstRead) then
                    clkCount <= 0; 
                    readData <= '1'; 
                    readingFirst <= '0'; 
                    reading <= '1'; 
                    readCount <= readCount + 1; 
                else 
                    clkCount <= clkCount + 1; 
                end if ;
            elsif (reading = '1') then
                if (clkCount = MaxClkCycles-1) then
                    clkCount <= 0; 
                    readData <= '1'; 
                    readCount <= readCount + 1; 
                else
                    clkCount <= clkCount + 1; 
                end if ;
            end if ;        
        end if ;
    end process ; -- proc1

    readFlag <= readData; 
    startRead <= startRead_t; 


end Behavioral;
