----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 08:50:31 AM
-- Design Name: 
-- Module Name: clkCounter_tb - Behavioral
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

entity clkCounter_tb is
--  Port ( );
end clkCounter_tb;

architecture Behavioral of clkCounter_tb is

component clkCounter_s is 
    port (  clk : in std_logic; 
            shiftFlag : in std_logic; 
            shiftData : out std_logic 
    ); 
end component; 

signal clk, shiftFlag, shiftData : std_logic;

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

    uut : clkCounter_s
    port map (
        clk => clk,
        shiftFlag => shiftFlag, 
        shiftData => shiftData
    ); 

    stim : process 
    begin
        shiftFlag <= '0'; 

        wait for 50ns;  

        shiftFlag <= '1';
        
        wait for 250ns; 
        
        shiftFlag <= '0'; 

        wait; 

    end process ; -- stim


end Behavioral;
