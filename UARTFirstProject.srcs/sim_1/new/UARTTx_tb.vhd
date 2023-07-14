----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2023 06:15:23 PM
-- Design Name: 
-- Module Name: UARTTx_tb - Behavioral
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

entity UARTTx_tb is
--  Port ( );
end UARTTx_tb;

architecture Behavioral of UARTTx_tb is

component UART_Tx is 
    port (  clk : in std_logic; 
            start : in std_logic; 
            rst : in std_logic; 
            data : in std_logic_vector (7 downto 0); 
            serialOUT : out std_logic; 
            TxReadyOUT : out std_logic; 
            TxDone : out std_logic
    );
end component; 

signal clk, start, rst, serialOUT, TxReadyOUT, TxDone : std_logic; 
signal data : std_logic_vector ( 7 downto 0); 

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

    uut : UART_Tx
    port map (
        clk => clk, 
        start => start, 
        rst => rst, 
        data => data, 
        serialOUT => serialOUT, 
        TxReadyOUT => TxReadyOUT, 
        TxDone => TxDone 
    ); 

    stim : process 
    begin

        start <= '0'; 
        rst <= '0'; 
        data <= "01111011";
        
        wait for 40ns; 

        start <= '1'; 

        wait for 20ns; 

        start <= '0'; 

        wait for 100ns; 
    
        data <= "01011011"; 

        wait for 740ns; 

        start <= '1'; 

        wait for 20ns; 

        start <= '0'; 

        wait; 
        
    end process ; -- stim


end Behavioral;
