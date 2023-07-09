----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2023 02:44:15 PM
-- Design Name: 
-- Module Name: clkCounter_s - Behavioral
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

entity clkCounter_s is
    port (  clk : in std_logic; 
            shiftFlag : in std_logic; 
            rst : in std_logic; 
            shiftData : out std_logic 
    );
end clkCounter_s;


architecture Behavioral of clkCounter_s is

constant MaxBits : integer := 10; 
constant maxClkCycles : integer := 1; --for desired baud rate set to 868; 2 is just for simulating 

signal bitCount : integer range 0 to MaxBits := 0; 
signal clkCount : integer range 0 to maxClkCycles := 0;

signal shiftData_t : std_logic := '0'; 
    
begin

    proc1 : process( clk, shiftFlag )
    begin
        if (rst = '1') then
            shiftData_t <= '0'; 
            bitCount <= 0; 
            clkCount <= 0; 
        elsif (rising_edge(clk)) then
            if (shiftFlag = '1' and bitCount < 10) then
                if (clkCount < maxClkCycles) then
                    shiftData_t <= '0'; 
                    clkCount <= clkCount + 1; 
                --elsif (shiftFlag = '0' and bitCount = 10) then
                --    bitCount <= 0; 
                else 
                    shiftData_t <= '1'; 
                    clkCount <= 0; 
                    bitCount <= bitCount + 1; 
                end if ;
            elsif (bitCount = 10) then
                shiftData_t <= '0'; 
            end if;
            if (shiftFlag = '0' and bitCount = 10) then
                bitCount <= 0; 
            end if ;
        end if ;
    end process ; -- proc1

    shiftData <= shiftData_t; 
end Behavioral;
