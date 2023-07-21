----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 03:43:18 PM
-- Design Name: 
-- Module Name: startDetect_tb - Behavioral
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

entity startDetect_tb is
--  Port ( );
end startDetect_tb;

architecture Behavioral of startDetect_tb is

component startDetect_Rx is 
    port (  clk : in std_logic; 
            TxData : in std_logic;
            reading : in std_logic; 
            rst : in std_logic;
            startRead : out std_logic 
    );
end component; 

signal clk, TxData, reading, rst, startRead : std_logic; 

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

    uut : startDetect_Rx
    port map (
        clk => clk, 
        TxData => TxData, 
        reading => reading, 
        rst => rst, 
        startRead => startRead
    ); 

    stim : process 
    begin
        
        TxData <= '1'; 
        reading <= '0'; 
        rst <= '0'; 
        
        wait for 40ns; 

        TxData <= '0'; 

        wait for 120ns;
        
        reading <= '1'; 

        wait for 20ns; 

        TxData <= '0'; 

        wait for 80ns; 

        TxData <= '1'; 

        wait for 20ns; 

        reading <= '0';

        wait for 40ns; 

        TxData <= '0'; 

        wait for 40ns; 

        rst <= '1'; 

        wait for 10ns; 

        rst <= '0'; 
        
        wait for 70ns; 

        reading <= '1'; 
        
        wait; 
        
    end process ; -- stim

end Behavioral;
