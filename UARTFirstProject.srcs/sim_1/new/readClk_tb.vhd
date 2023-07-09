----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/03/2023 07:05:45 PM
-- Design Name: 
-- Module Name: readClk_tb - Behavioral
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

entity readClk_tb is
--  Port ( );
end readClk_tb;

architecture Behavioral of readClk_tb is

component readClk_Rx is 
    port (  clk : in std_logic;     
            setupFlag : in std_logic; 
            rst : in std_logic; 
            startRead : out std_logic; 
            readFlag : out std_logic 
    );
end component; 

signal clk, setupFlag, rst, startRead, readFlag : std_logic; 

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

    uut : readClk_Rx
    port map (
        clk => clk, 
        setupFlag => setupFlag, 
        rst => rst, 
        startRead => startRead,  
        readFlag => readFlag
    ); 

    stim : process 
    begin
        
        setupFlag <= '0'; 
        rst <= '0'; 

        wait for 40ns; 

        setupFlag <= '1'; 

        wait for 20ns; 

        setupFlag <= '0';

        wait for 140ns; 

        rst <= '1'; 

        wait for 20ns; 

        setupFlag <= '1'; 

        wait for 20ns;  
        
        rst <= '0'; 
        
        wait for 20ns; 

        setupFlag <= '0'; 

        wait; 


    end process ; -- stim

end Behavioral;
