----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2023 02:05:15 PM
-- Design Name: 
-- Module Name: UART_Tx - Behavioral
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

entity UART_Tx is
    generic (N : integer := 8); 
    port (  clk : in std_logic; 
            start : in std_logic; 
            rst : in std_logic; 
            data : in std_logic_vector (N-1 downto 0); 
            serialOUT : out std_logic; 
            TxReadyOUT : out std_logic; 
            TxDone : out std_logic
    );
end UART_Tx;

architecture Behavioral of UART_Tx is

    -- Components --
component SM_Tx is 
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
end component; 

component Du_s is 
    generic (N : integer  := 8 ); 
    port (  loadFlag : in std_logic;
            shiftFlag : in std_logic; 
            shiftData : in std_logic; 
            clk : in std_logic; 
            rst : in std_logic; 
            data : in std_logic_vector (N-1 downto 0); 
            shiftDone : out std_logic; 
            serialOUT : out std_logic
    ); 
end component; 

component clkCounter_s is 
    port (  clk : in std_logic; 
            shiftFlag : in std_logic; 
            rst : in std_logic; 
            shiftData : out std_logic 
    ); 
end component; 

component delayCounter_s is 
    port (  startDelay : in std_logic; 
            clk : in std_logic;
            rst : in std_logic; 
            delayOUT : out std_logic
    );
end component; 

component TxReady_s is 
    port (  start : in std_logic; 
            TxDone : in std_logic; 
            delayIN : in std_logic; 
            clk : in std_logic; 
            rst : in std_logic; 
            TxReadyOUT : out std_logic              
    ); 
end component; 

    -- Signals --
signal startO : std_logic := '0'; 
signal shiftDone : std_logic := '0'; 
signal delayIN : std_logic := '0'; 
signal loadFlag : std_logic := '0'; 
signal shiftFlag : std_logic := '0'; 
signal startDelay : std_logic := '0'; 
signal shiftData : std_logic := '0'; 
signal delayINOUT : std_logic := '0'; 
    -- For OUTs -- 
signal serialOUT_t : std_logic := '0'; 
signal TxReadyOUT_t : std_logic := '0'; 
signal TxDone_t : std_logic := '0';
    -- Dummies -- 
signal edgeLeadO, edgeFollowO, doneSh : std_logic; 


begin

    EdgeDetect(start, clk, startO, edgeLeadO, edgeFollowO); 

    SM0 : SM_Tx 
    port map (
        clk => clk, 
        startO => startO, 
        shiftDone => shiftDone, 
        delayIN => delayINOUT, 
        rst => rst, 
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag, 
        startDelay => startDelay, 
        TxDone => TxDone_t, 
        doneSh => doneSh
    ); 

    DU0 : DU_s 
    port map (
        loadFlag => loadFlag, 
        shiftFlag => shiftFlag, 
        shiftData => shiftData, 
        clk => clk, 
        rst => rst, 
        data => data, 
        shiftDone => shiftDone, 
        serialOUT => serialOUT_t
    ); 
    
    clkC0 : clkCounter_s
    port map (
        clk => clk, 
        shiftFlag => shiftFlag, 
        rst => rst, 
        shiftData => shiftData
    ); 

    delay0 : delayCounter_s 
    port map (
        startDelay => startDelay, 
        clk => clk, 
        rst => rst, 
        delayOUT => delayINOUT
    ); 

    TxReady0 : TxReady_s 
    port map (
        start => startO, 
        TxDone => TxDone_t,
        delayIN => delayINOUT, 
        clk => clk, 
        rst => rst,
        TxReadyOUT => TxReadyOut_t
    );

    SerialOUT <= serialOUT_t; 
    TxReadyOUT <= TxReadyOUT_t; 
    TxDone <= TxDone_t; 


end Behavioral;
