----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2023 12:50:10 PM
-- Design Name: 
-- Module Name: delayCounter_tb - Behavioral
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

entity delayCounter_tb is
--  Port ( );
end delayCounter_tb;

architecture Behavioral of delayCounter_tb is

component delayCounter_s is 
    port (  startDelay : in std_logic; 
            clk : in std_logic; 
            delayOUT : out std_logic
    ); 
end component; 

signal startDelay, clk, delayOUT : std_logic; 

constant clk_period : time := 20ns;
signal clk_stop : boolean; 

begin

    clkproc : process 
    begin
        clk <= '1';  
        wait for clk_period/2; 
        clk <= '0'; 
        wait for clk_period/2; 
    end process ; -- clkproc

    dut : delayCounter_s 
    port map (
        startDelay => startDelay, 
        clk => clk, 
        delayOUT => delayOUT
    ); 

    stim : process 
    begin
        startDelay <= '0'; 

        wait for 50ns; 

        startDelay <= '1'; 

        wait; 


        
    end process ; -- stim


end Behavioral;
