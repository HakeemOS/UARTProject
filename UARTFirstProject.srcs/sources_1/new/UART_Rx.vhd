----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/12/2023 08:45:17 AM
-- Design Name: 
-- Module Name: UART_Rx - Behavioral
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
use myLib.paraPcr_p.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_Rx is
    generic (N : integer := 8);
    port (  clk : in std_logic; 
            start : in std_logic;
            TxData : in std_logic;
            rst : in std_logic; 
            validated : out std_logic; 
            invalid : out std_logic; 
            RxDone : out std_logic; 
            data : out std_logic_vector (N-1 downto 0)
    );
end UART_Rx;

architecture Behavioral of UART_Rx is

    -- Componenets -- 
component SM_Rx is 
    port (  clk : in std_logic; 
            startO : in std_logic; 
            startRead : in std_logic; 
            doneRead : in std_logic; 
            validated : in std_logic;
            invalid : in std_logic; 
            rst : in std_logic; 
            setupFlag : out std_logic; 
            RxDone : out std_logic 
    );
end component; 

    component readClk_Rx is 
    port (  clk : in std_logic;     
            setupFlag : in std_logic; 
            rst : in std_logic; 
            startRead : out std_logic; 
            readFlag : out std_logic 
        );
end component; 

component RU_Rx is 
    generic (N : integer := 8); 
    port (  clk : in std_logic;
            startRead : in std_logic; 
            readFlag : in std_logic; 
            TxData : in std_logic; 
            rst : in std_logic; 
            doneRead : out std_logic;
            validated : out std_logic; 
            invalid : out std_logic; 
            data : out std_logic_vector (N-1 downto 0) 
    ); 
end component; 

    -- Signals -- 
signal startO : std_logic := '0'; 
signal setupFlag : std_logic := '0'; 
signal startRead : std_logic := '0'; 
signal readFlag : std_logic := '0'; 
signal doneRead : std_logic := '0'; 
signal validated_t : std_logic := '0'; 
signal invalid_t : std_logic := '0';
signal RxDone_t : std_logic := '0'; 
signal data_t : std_logic_vector (N-1 downto 0) := (others => '0'); 
    -- Dummies -- 
signal edgeLeadO, edgeFollowO : std_logic; 

begin

    EdgeDetect(start, clk, startO, edgeLeadO, edgeFollowO); 

    RxCLK0 : readClk_Rx
    port map (
        clk => clk, 
        setupFlag => setupFlag, 
        rst => rst, 
        startRead => startRead, 
        readFlag => readFlag
    ); 

    SM0 : SM_Rx 
    port map (
        clk => clk, 
        startO => startO, 
        startRead => startRead, 
        doneRead => doneRead, 
        validated => validated_t, 
        invalid => invalid_t, 
        rst => rst, 
        setupFlag => setupFlag, 
        RxDone => RxDone_t 
    ); 

    RU0 : RU_Rx 
    port map (
        clk => clk, 
        startRead => startRead, 
        readFlag => readFlag, 
        TxData => TxData, 
        rst => rst, 
        doneRead => doneRead, 
        validated => validated_t,
        invalid => invalid_t, 
        data => data_t
    ); 


    validated <= validated_t; 
    invalid <= invalid_t; 
    RxDone <= RxDone_t; 
    data <= data_t; 

end Behavioral;
