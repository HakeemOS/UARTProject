----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 05:20:41 PM
-- Design Name: 
-- Module Name: readClkv2_Rx - Behavioral
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

entity readClkv2_Rx is
    port (  clk : in std_logic; 
            startRead : in std_logic; 
            rst : in std_logic; 
            readFlag : out std_logic 
    );
end readClkv2_Rx;

architecture Behavioral of readClkv2_Rx is

constant baudRate : integer := 19200; 
constant clkRate : integer := 50000000; 
constant MaxRead : integer := 10; 
constant MaxClkCycles : integer := 6; 

signal readData : std_logic := '0'; 
signal reading : std_logic := '0'; 
signal singleDelay : std_logic := '0'; 
signal readCount : integer range 0 to MaxRead := 0; 
signal clkCount : integer range 0 to MaxClkCycles := 0; 

begin
    proc1 : process( clk, startRead, rst )
    begin
        if (rst = '1') then
            readData <= '0'; 
            reading <= '0'; 
            singleDelay <= '0'; 
            readCount <= 0; 
            clkCount <= 0; 
        elsif (rising_edge(clk)) then
            readData <= '0'; 
            singleDelay <= '0'; 
            if (startRead = '1') then
                readData <= '1'; 
                readCount <= readCount + 1; 
                clkCount <= 0;  
                reading <= '1';
            elsif (readCount = MaxRead) then
                readCount <= 0; 
                clkCount <= 0; 
                reading <= '0';
            elsif (reading = '1') then
                if (clkCount = MaxClkCycles-1 ) then
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



end Behavioral;
