----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2023 07:45:53 PM
-- Design Name: 
-- Module Name: SM_Rx - Behavioral
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

entity SM_Rx is
    port (  clk : in std_logic; 
            startO : in std_logic; 
            startRead : in std_logic; 
            doneRead : in std_logic; 
            rst : in std_logic; 
            setupFlag : out std_logic; 
            readFlag : out std_logic; 
            RxDone : out std_logic 
    );
end SM_Rx;

architecture Behavioral of SM_Rx is
    
type states is (init, setup, readbit, validate); 

signal stt : states := init; 
signal RxDone_t : std_logic := '0'; 
signal setupData : std_logic := '0'; 
signal readData : std_logic := '0'; 
signal startSetup : std_logic := '0'; 
signal validated : std_logic := '0'; 

begin
    trns : process( clk, rst, startO )
    begin
        if (rst = '1') then
            stt <= init; 
        elsif (rising_edge(clk)) then
            case( stt ) is
                when init =>
                    if (startSetup = '1') then
                        stt <= setup; 
                    else 
                        stt <= init; 
                    end if ;
                when setup => 
                    if (startRead = '1') then
                        stt <= readbit; 
                    else
                        stt <= setup; 
                    end if ;
                when readbit => 
                    if (doneRead = '1') then
                        stt <= validate;  
                    else
                        stt <= readbit; 
                    end if ;
                when others =>
                    if (validated = '1') then
                        if (startSetup = '1') then
                            stt <= setup; 
                        else
                            stt <= init; 
                        end if ;
                    end if ;
            end case ;
        end if ;
    end process ; -- trns

    output : process( clk, startO )
    begin
        -- Defaults -- 
        RxDone_t <= '0'; 
        startSetup <= '0'; 
        setupData <= '0'; 

        case( stt ) is
            when init =>
                RxDone_t <= '1'; 
                if (startO = '1') then
                    startSetup <= '1'; 
                end if ;                
            when setup => 
                setupData <= '1'; 
            when others =>
        
        end case ;
    end process ; -- output

    setupFlag <= setupData; 
    readFlag <= readData; 
    RxDone <= RxDone_t; 

end Behavioral;
