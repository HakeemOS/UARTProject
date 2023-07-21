----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2023 06:15:06 PM
-- Design Name: 
-- Module Name: UARTv2Rx_tb - Behavioral
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

entity UARTv2Rx_tb is
--  Port ( );
end UARTv2Rx_tb;

architecture Behavioral of UARTv2Rx_tb is

component UARTv2_Rx is 
    port (  clk : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            validated : out std_logic; 
            invalid : out std_logic; 
            RxDone : out std_logic; 
            data : out std_logic_vector (7 downto 0)
    );
end component; 

signal clk, TxData, rst, validated, invalid, RxDone : std_logic; 
signal data : std_logic_vector (7 downto 0); 

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

    uut : UARTv2_Rx
    port map (
        clk => clk, 
        TxData => TxData, 
        rst => rst, 
        validated => validated, 
        invalid => invalid, 
        RxDone => RxDone, 
        data => data 
    );

    stim : process 
    begin
        
        TxData <= '1'; 
        rst <= '0'; 

        wait for 40ns; 

        TxData <= '0'; -- First 

        wait for 120ns; 

        TxData <= '0'; -- second 

        wait for 120ns; 

        TxData <= '1'; -- third

        wait for 120ns; 

        TxData <= '1'; -- fourth 

        wait for 120ns; 

        TxData <= '0'; --fifth 

        wait for 120ns; 

        TxData <= '1'; --sixth 

        wait for 120ns; 

        TxData <= '1'; -- seventh 

        wait for 120ns; 

        TxData <= '0'; -- eighth

        wait for 120ns; 

        TxData <= '1'; -- ninth 

        wait for 120ns; 

        TxData <= '1'; -- tenth

        wait; 
    end process ; -- stim
end Behavioral;
