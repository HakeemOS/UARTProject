----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/09/2023 08:44:12 AM
-- Design Name: 
-- Module Name: RU_tb - Behavioral
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

entity RU_tb is
--  Port ( );
end RU_tb;

architecture Behavioral of RU_tb is

component RU_Rx is 
    port (  clk : in std_logic;
            startRead : in std_logic; 
            readFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            invalid : out std_logic; 
            data : out std_logic_vector (7 downto 0) 
    );
end component; 

signal clk, startRead, readFlag, TxData, rst, doneRead, validated, invalid : std_logic; 
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

    uut : RU_Rx
    port map (
        clk => clk, 
        startRead => startRead, 
        readFlag => readFlag, 
        TxData => TxData, 
        rst => rst, 
        doneRead => doneRead, 
        validated => validated,  
        invalid => invalid, 
        data => data
    ); 
    

    stim : process  
    begin
        startRead <= '0'; 
        readFlag <= '0'; 
        TxData <= '0'; 
        rst <= '1'; 

        wait for 20ns; 

        startRead <= '1'; 

        wait for 20ns;

        rst <= '0'; 

        wait for 20ns; 

        startRead <= '0';
        TxData <= '0';  

        wait for 20ns; 

        readFlag <= '1'; --1st read 

        wait for 20ns; 

        readFlag <= '0'; 
        TxData <= '0';  

        wait for 20ns; 

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '0';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '0';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- last read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '0';  

        wait for 20ns;

        readFlag <= '1'; -- extra read 

        wait for 20ns; 

        readFlag <= '0';

        wait for 100ns;

        startRead <= '1'; 

        wait for 20ns; 
        
        startRead <= '0';
        TxData <= '1';  

        wait for 20ns; 

        readFlag <= '1'; --1st read 

        wait for 20ns; 

        readFlag <= '0'; 
        TxData <= '0';  

        wait for 20ns; 

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '0';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '0';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- read 

        wait for 20ns; 

        readFlag <= '0';
        TxData <= '1';  

        wait for 20ns;

        readFlag <= '1'; -- last read 

        wait for 20ns; 

        readFlag <= '0';

        wait; 
        






    end process ; -- stim
end Behavioral;
