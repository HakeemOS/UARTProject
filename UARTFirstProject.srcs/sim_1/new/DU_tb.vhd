----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2023 07:21:38 PM
-- Design Name: 
-- Module Name: DU_tb - Behavioral
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

entity DU_tb is
--  Port ( );
end DU_tb;

architecture Behavioral of DU_tb is

component DU_s is 
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic; 
            shiftData : in std_logic; 
            clk : in std_logic; 
            data : in std_logic_vector (7 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    );
end component;

signal clk, loadFlag, shiftFlag, shiftData, shiftDone, serialOUT : std_logic; 
signal data : std_logic_vector (7 downto 0); 

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

    uut : DU_s 
    port map (
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag,
        shiftData => shiftData,
        clk => clk,
        data => data,
        shiftDone => shiftDone, 
        serialOUT => serialOUT
    ); 

    stim : process  
    begin
        data <= "01101010"; 
        loadFlag <= '0'; 
        shiftFlag <= '0';
        shiftData <= '0';

        wait for 40ns; 

        loadFlag <= '1'; 

        wait for 20ns; 

        loadFlag <= '0'; 

        wait for 40ns; 
        
        shiftFlag <= '1';

        wait for 40ns; 

        shiftData <= '1';   --1 

        wait for 20ns;

        shiftData <= '0'; 

        wait for 80ns;
        
        shiftData <= '1';   --2

        wait for 20ns;

        shiftData <= '0'; 

        wait for 80ns;

        shiftData <= '1';   --3

        wait for 20ns;

        shiftData <= '0'; 

        wait for 80ns;

        shiftData <= '1';   --4

        wait for 20ns;

        shiftData <= '0';

        wait for 80ns;

        shiftData <= '1';   --5

        wait for 20ns;

        shiftData <= '0';

        wait for 80ns;

        shiftData <= '1';   --6

        wait for 20ns;

        shiftData <= '0';

        wait for 80ns;

        shiftData <= '1';   --7

        wait for 20ns;

        shiftData <= '0';

        wait for 80ns;

        shiftData <= '1';   --8

        wait for 20ns;

        shiftData <= '0';

        wait for 80ns;

        shiftData <= '1'; --9

        wait for 20ns;

        shiftData <= '0';
        
        wait for 80ns;

        shiftData <= '1'; --10 

        wait for 20ns;

        shiftData <= '0';

        wait; 
        



    end process ; -- stim

end Behavioral;
