----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2023 02:44:15 PM
-- Design Name: 
-- Module Name: SM_s - Behavioral
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
library myLib; 
use myLib.arithFx_p.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SM_s is
    port (  clk : in std_logic;
            startO : in std_logic; 
            shiftDone : in std_logic; 
            delayIN : in std_logic; 
            rst : in std_logic; 
            loadFlag : out std_logic; 
            shiftFlag : out std_logic; 
            startDelay : out std_logic; 
            TxDone : out std_logic; 
            doneSh : out std_logic 
    );
end SM_s;

architecture Behavioral of SM_s is

type states is (init, load, shift); 

signal stt : states := init; 
signal doneSh_t : std_logic := '0'; 
signal startDelay_t : std_logic := '0'; 
signal TxDone_t : std_logic := '0'; 
signal startLoad : std_logic := '0'; 
signal clkDelay : std_logic := '0'; 
signal loadData : std_logic := '0'; 
signal shiftData : std_logic := '0'; 

begin
    trns : process( clk, rst, startO, doneSh_t )
    begin
        if(rst = '1') then
            stt <= init; 
        elsif (rising_edge(clk)) then
            case( stt ) is
                when init =>
                    if (startLoad = '1') then
                        stt <= load; 
                    else
                        stt <= init; 
                    end if ;
                when load => stt <= shift; 
                when others => 
                    if (doneSh_t = '1' and clkDelay = '1') then
                        stt <= init; 
                    else
                        stt <= shift; 
                    end if ;
            end case ;
        end if; 
    end process ; -- trns

    output : process( clk, startO  )
    begin
        case( stt ) is
            when init =>
                doneSh_t <= '0'; 
                TxDone_t <= '1'; 
                if (startO = '1' and clkDelay = '1') then
                    startLoad <= '1'; 
                    clkDelay <= '0'; 
                end if ; 
                if (DelayIN = '1') then
                    clkDelay <= '1';   
                    startDelay_t <= '0';        
                end if ;
            when load =>
                TxDone_t <= '0'; 
                startLoad <= '0'; 
                loadData <= '1';
            when others =>
                loadData <= '0';
                if ( shiftDone = '1') then
                    shiftData <= '0'; 
                    doneSh_t <= '1'; 
                    startDelay_t <= '1'; 
                elsif (shiftDone = '0') then
                    shiftData <= '1'; 
                end if ;
        
        end case ;
        
    end process ; -- output

    startDelay <= startDelay_t; 
    TxDone <= TxDone_t; 
    loadFlag <= loadData; 
    doneSh <= doneSh_t; 
    shiftFlag <= shiftData; 
    

end Behavioral;
