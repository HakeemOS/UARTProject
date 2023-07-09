----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2023 12:28:40 PM
-- Design Name: 
-- Module Name: delayCounter_s - Behavioral
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

entity delayCounter_s is
    port (  startDelay : in std_logic; 
            clk : in std_logic;
            rst : in std_logic; 
            delayOUT : out std_logic
    );
end delayCounter_s;

architecture Behavioral of delayCounter_s is

constant MaxCount : integer := 4; -- for 60us delay set to 6000; set to 4 for simulating purposes 

signal delayCnt : integer := 1; 
signal delayOUT_t : std_logic := '1'; 


begin

    proc1 : process( clk )
    begin
        if (rst = '1') then
            delayOUT_t <= '0';  
            delayCnt <= 1; 
        elsif (rising_edge(clk)) then
            if (startDelay = '1') then        
                if (delayCnt = MaxCount) then
                    delayOUT_t <= '1'; 
                    delayCnt <= 1;
                else 
                    delayCnt <= delayCnt + 1; 
                    delayOUT_t <= '0'; 
                end if ;
            elsif (startDelay = '0') then
                delayCnt <= 1; 
            end if;
        end if ;
    end process ; -- proc1

    delayOUT <= delayOUT_t; 


end Behavioral;
