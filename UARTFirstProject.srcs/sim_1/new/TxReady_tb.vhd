----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/13/2023 01:31:51 PM
-- Design Name: 
-- Module Name: TxReady_tb - Behavioral
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

entity TxReady_tb is
--  Port ( );
end TxReady_tb;

architecture Behavioral of TxReady_tb is

component TxReady_s is 
    port (  start : in std_logic; 
            TxDone : in std_logic; 
            delayIN : in std_logic;
            clk : in std_logic; 
            TxReadyOUT : out std_logic

    ); 
end component; 

signal start, Txdone, delayIN, clk, TxReadyOut : std_logic; 

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

    uut : TxReady_s
    port map (
        start => start, 
        TxDone => TxDone, 
        delayIN => delayIN,
        clk => clk, 
        TxReadyOUT => TxReadyOUT
    ); 

    stim : process
    begin

        start <= '0'; 
        TxDone <= '0'; 
        delayIN <= '0';

        wait for 20ns; 
        
        start <= '1'; 

        wait for 20ns; 

        start <= '0'; 

        wait for 300ns; 

        TxDone <= '1'; 
        delayIN <= '1'; 

        wait for 60ns; 

        delayIN <= '0'; 

        wait; 

    end process ; -- stim


end Behavioral;
