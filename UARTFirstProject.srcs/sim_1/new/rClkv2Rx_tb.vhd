----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 05:33:32 PM
-- Design Name: 
-- Module Name: rClkv2Rx_tb - Behavioral
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

entity rClkv2Rx_tb is
--  Port ( );
end rClkv2Rx_tb;

architecture Behavioral of rClkv2Rx_tb is

component readClkv2_Rx is 
    port (  clk : in std_logic; 
            startRead : in std_logic; 
            rst : in std_logic; 
            readFlag : out std_logic 
    );
end component; 

signal clk, startRead, rst, readFlag : std_logic; 

signal clk_period : time := 20ns; 
signal clk_stop : boolean; 

begin

    clkproc : process 
    begin
        clk <= '1';  
        wait for clk_period/2; 
        clk <= '0'; 
        wait for clk_period/2; 
    end process ; -- clkproc

    uut : readClkv2_Rx 
    port map (
        clk => clk,
        startRead => startRead, 
        rst => rst, 
        readFlag => readFlag
    );

    stim : process
    begin
        
        startRead <= '0'; 
        rst <= '0'; 

        wait for 40ns; 

        startRead <= '1'; 

        wait for 20ns; 

        startRead <= '0'; 

        wait; 
        
    end process ; -- stim

end Behavioral;
