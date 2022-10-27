-- -------------------------------------------------------------
-- 
-- File Name: hdl_32bits\hdlsrc\fec_ber_hw_V2\decoder_control_src_Chart.vhd
-- Created: 2022-10-27 15:30:16
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: decoder_control_src_Chart
-- Source Path: fec_ber_hw_V2/FEC Ctrl/Chart
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.decoder_control_src_FEC_Ctrl_pkg.ALL;

ENTITY decoder_control_src_Chart IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        ctrl_word                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        block_length                      :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        load                              :   IN    std_logic;
        s_axis_tvalid                     :   IN    std_logic;
        s_axis_lane1_tdata                :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_lane2_tdata                :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_lane3_tdata                :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_lane0_tdata                :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_ctrl_tvalid                :   OUT   std_logic;
        m_axis_ctrl_tdata                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        m_axis_ctrl_tlast                 :   OUT   std_logic;
        m_axis_tvalid                     :   OUT   std_logic;
        s_axis_status_tready              :   OUT   std_logic;
        m_axis_lane0_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_lane1_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_lane2_tdata                :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_lane3_tdata                :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
        );
END decoder_control_src_Chart;


ARCHITECTURE rtl OF decoder_control_src_Chart IS

  -- Functions
  -- HDLCODER_TO_STDLOGIC 
  FUNCTION hdlcoder_to_stdlogic(arg: boolean) RETURN std_logic IS
  BEGIN
    IF arg THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL ctrl_word_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL block_length_unsigned            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL s_axis_lane1_tdata_unsigned      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL s_axis_lane2_tdata_unsigned      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL s_axis_lane3_tdata_unsigned      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL s_axis_lane0_tdata_unsigned      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL count                            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL n                                : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL loaded_ctrl                      : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL loaded_n                         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_ctrl_tdata_tmp            : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL state                            : T_stateType;  -- enum type stateType (8 enums)
  SIGNAL m_axis_lane0_tdata_tmp           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane1_tdata_tmp           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane2_tdata_tmp           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane3_tdata_tmp           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_ctrl_tvalid_reg           : std_logic;
  SIGNAL m_axis_ctrl_tdata_reg            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_ctrl_tlast_reg            : std_logic;
  SIGNAL m_axis_tvalid_reg                : std_logic;
  SIGNAL s_axis_status_tready_reg         : std_logic;
  SIGNAL state_reg                        : T_stateType;  -- enum type stateType (8 enums)
  SIGNAL m_axis_lane0_tdata_reg           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane1_tdata_reg           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane2_tdata_reg           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane3_tdata_reg           : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL count_next                       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL n_next                           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL loaded_ctrl_next                 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL loaded_n_next                    : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_ctrl_tvalid_reg_next      : std_logic;
  SIGNAL m_axis_ctrl_tdata_reg_next       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_ctrl_tlast_reg_next       : std_logic;
  SIGNAL m_axis_tvalid_reg_next           : std_logic;
  SIGNAL s_axis_status_tready_reg_next    : std_logic;
  SIGNAL state_reg_next                   : T_stateType;  -- enum type stateType (8 enums)
  SIGNAL m_axis_lane0_tdata_reg_next      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane1_tdata_reg_next      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane2_tdata_reg_next      : unsigned(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_lane3_tdata_reg_next      : unsigned(127 DOWNTO 0);  -- ufix128

BEGIN
  ctrl_word_unsigned <= unsigned(ctrl_word);

  block_length_unsigned <= unsigned(block_length);

  s_axis_lane1_tdata_unsigned <= unsigned(s_axis_lane1_tdata);

  s_axis_lane2_tdata_unsigned <= unsigned(s_axis_lane2_tdata);

  s_axis_lane3_tdata_unsigned <= unsigned(s_axis_lane3_tdata);

  s_axis_lane0_tdata_unsigned <= unsigned(s_axis_lane0_tdata);

  Chart_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      state_reg <= INIT;
      -- Local
      count <= to_unsigned(0, 32);
      n <= to_unsigned(0, 32);
      loaded_n <= to_unsigned(0, 32);
      loaded_ctrl <= to_unsigned(0, 32);
      --
      -- DATA Stream
      m_axis_tvalid_reg <= '0';
      m_axis_lane0_tdata_reg <= to_unsigned(0, 128);
      m_axis_lane1_tdata_reg <= to_unsigned(0, 128);
      m_axis_lane2_tdata_reg <= to_unsigned(0, 128);
      m_axis_lane3_tdata_reg <= to_unsigned(0, 128);
      --
      -- CTRL Stream
      m_axis_ctrl_tdata_reg <= to_unsigned(0, 32);
      m_axis_ctrl_tlast_reg <= '0';
      m_axis_ctrl_tvalid_reg <= '0';
      --
      -- STATUS Stream
      s_axis_status_tready_reg <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        count <= count_next;
        n <= n_next;
        loaded_ctrl <= loaded_ctrl_next;
        loaded_n <= loaded_n_next;
        m_axis_ctrl_tvalid_reg <= m_axis_ctrl_tvalid_reg_next;
        m_axis_ctrl_tdata_reg <= m_axis_ctrl_tdata_reg_next;
        m_axis_ctrl_tlast_reg <= m_axis_ctrl_tlast_reg_next;
        m_axis_tvalid_reg <= m_axis_tvalid_reg_next;
        s_axis_status_tready_reg <= s_axis_status_tready_reg_next;
        state_reg <= state_reg_next;
        m_axis_lane0_tdata_reg <= m_axis_lane0_tdata_reg_next;
        m_axis_lane1_tdata_reg <= m_axis_lane1_tdata_reg_next;
        m_axis_lane2_tdata_reg <= m_axis_lane2_tdata_reg_next;
        m_axis_lane3_tdata_reg <= m_axis_lane3_tdata_reg_next;
      END IF;
    END IF;
  END PROCESS Chart_process;

  Chart_output : PROCESS (block_length_unsigned, count, ctrl_word_unsigned, load, loaded_ctrl, loaded_n,
       m_axis_ctrl_tdata_reg, m_axis_ctrl_tlast_reg, m_axis_ctrl_tvalid_reg,
       m_axis_lane0_tdata_reg, m_axis_lane1_tdata_reg, m_axis_lane2_tdata_reg,
       m_axis_lane3_tdata_reg, m_axis_tvalid_reg, n,
       s_axis_lane0_tdata_unsigned, s_axis_lane1_tdata_unsigned,
       s_axis_lane2_tdata_unsigned, s_axis_lane3_tdata_unsigned,
       s_axis_status_tready_reg, s_axis_tvalid, state_reg)
    VARIABLE sf_internal_predicateOutput : std_logic;
    VARIABLE b_sf_internal_predicateOutput : std_logic;
    VARIABLE c_sf_internal_predicateOutput : std_logic;
    VARIABLE d_sf_internal_predicateOutput : std_logic;
    VARIABLE e_sf_internal_predicateOutput : std_logic;
    VARIABLE sf_internal_predicateoutput_0 : std_logic;
    VARIABLE sf_internal_predicateoutput_1 : std_logic;
    VARIABLE sf_internal_predicateoutput_2 : std_logic;
    VARIABLE b_sf_internal_predicateoutput_0 : std_logic;
    VARIABLE sf_internal_predicateoutput_3 : std_logic;
    VARIABLE b_sf_internal_predicateoutput_1 : std_logic;
    VARIABLE add_temp : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_0 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_1 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_2 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_3 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_4 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_5 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_6 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_7 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_8 : unsigned(32 DOWNTO 0);
    VARIABLE add_temp_9 : unsigned(32 DOWNTO 0);
  BEGIN
    sf_internal_predicateOutput := '0';
    b_sf_internal_predicateOutput := '0';
    c_sf_internal_predicateOutput := '0';
    d_sf_internal_predicateOutput := '0';
    e_sf_internal_predicateOutput := '0';
    sf_internal_predicateoutput_0 := '0';
    sf_internal_predicateoutput_1 := '0';
    sf_internal_predicateoutput_2 := '0';
    b_sf_internal_predicateoutput_0 := '0';
    sf_internal_predicateoutput_3 := '0';
    b_sf_internal_predicateoutput_1 := '0';
    add_temp := to_unsigned(0, 33);
    add_temp_0 := to_unsigned(0, 33);
    add_temp_1 := to_unsigned(0, 33);
    add_temp_2 := to_unsigned(0, 33);
    add_temp_3 := to_unsigned(0, 33);
    add_temp_4 := to_unsigned(0, 33);
    add_temp_5 := to_unsigned(0, 33);
    add_temp_6 := to_unsigned(0, 33);
    add_temp_7 := to_unsigned(0, 33);
    add_temp_8 := to_unsigned(0, 33);
    add_temp_9 := to_unsigned(0, 33);
    count_next <= count;
    m_axis_ctrl_tvalid_reg_next <= m_axis_ctrl_tvalid_reg;
    m_axis_ctrl_tdata_reg_next <= m_axis_ctrl_tdata_reg;
    m_axis_ctrl_tlast_reg_next <= m_axis_ctrl_tlast_reg;
    m_axis_tvalid_reg_next <= m_axis_tvalid_reg;
    s_axis_status_tready_reg_next <= s_axis_status_tready_reg;
    state_reg_next <= state_reg;
    m_axis_lane0_tdata_reg_next <= m_axis_lane0_tdata_reg;
    m_axis_lane1_tdata_reg_next <= m_axis_lane1_tdata_reg;
    m_axis_lane2_tdata_reg_next <= m_axis_lane2_tdata_reg;
    m_axis_lane3_tdata_reg_next <= m_axis_lane3_tdata_reg;
    n_next <= n;
    loaded_ctrl_next <= loaded_ctrl;
    loaded_n_next <= loaded_n;
    CASE state_reg IS
      WHEN COUNT_DIN =>
        sf_internal_predicateOutput := hdlcoder_to_stdlogic((hdlcoder_to_stdlogic(count >= n) AND s_axis_tvalid) = '1');
        IF sf_internal_predicateOutput = '1' THEN 
          state_reg_next <= CTRL;
          -- Local
          count_next <= to_unsigned(1, 32);
          n_next <= loaded_n;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= loaded_ctrl;
          m_axis_ctrl_tlast_reg_next <= '1';
          m_axis_ctrl_tvalid_reg_next <= '1';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          b_sf_internal_predicateOutput := hdlcoder_to_stdlogic((load AND s_axis_tvalid) = '1');
          IF b_sf_internal_predicateOutput = '1' THEN 
            state_reg_next <= LOAD_VALID;
            -- Local
            add_temp_6 := resize(count, 33) + to_unsigned(1, 33);
            IF add_temp_6(32) /= '0' THEN 
              count_next <= X"FFFFFFFF";
            ELSE 
              count_next <= add_temp_6(31 DOWNTO 0);
            END IF;
            loaded_n_next <= block_length_unsigned;
            loaded_ctrl_next <= ctrl_word_unsigned;
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '1';
            m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
            m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
            m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
            m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
            m_axis_ctrl_tlast_reg_next <= '0';
            m_axis_ctrl_tvalid_reg_next <= '0';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '1';
          ELSE 
            c_sf_internal_predicateOutput := hdlcoder_to_stdlogic((hdlcoder_to_stdlogic(count >= n) AND ( NOT s_axis_tvalid)) = '1');
            IF c_sf_internal_predicateOutput = '1' THEN 
              count_next <= to_unsigned(0, 32);
              state_reg_next <= IDLE;
              -- Local
              --
              -- DATA Stream
              m_axis_tvalid_reg_next <= '0';
              m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
              --
              -- CTRL Stream
              m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
              m_axis_ctrl_tlast_reg_next <= '0';
              m_axis_ctrl_tvalid_reg_next <= '0';
              --
              -- STATUS Stream
              s_axis_status_tready_reg_next <= '0';
            ELSE 
              d_sf_internal_predicateOutput := hdlcoder_to_stdlogic((( NOT load) AND ( NOT s_axis_tvalid)) = '1');
              IF d_sf_internal_predicateOutput = '1' THEN 
                state_reg_next <= WAITING;
                -- Local
                --
                -- DATA Stream
                m_axis_tvalid_reg_next <= '0';
                m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
                m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
                m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
                m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
                --
                -- CTRL Stream
                m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
                m_axis_ctrl_tlast_reg_next <= '0';
                m_axis_ctrl_tvalid_reg_next <= '0';
                --
                -- STATUS Stream
                s_axis_status_tready_reg_next <= '1';
              ELSE 
                e_sf_internal_predicateOutput := hdlcoder_to_stdlogic((load AND ( NOT s_axis_tvalid)) = '1');
                IF e_sf_internal_predicateOutput = '1' THEN 
                  state_reg_next <= LOAD_NVALID;
                  -- Local
                  loaded_n_next <= block_length_unsigned;
                  loaded_ctrl_next <= ctrl_word_unsigned;
                  --
                  -- DATA Stream
                  m_axis_tvalid_reg_next <= '0';
                  m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
                  m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
                  m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
                  m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
                  --
                  -- CTRL Stream
                  m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
                  m_axis_ctrl_tlast_reg_next <= '0';
                  m_axis_ctrl_tvalid_reg_next <= '0';
                  --
                  -- STATUS Stream
                  s_axis_status_tready_reg_next <= '1';
                ELSE 
                  -- Local
                  add_temp_9 := resize(count, 33) + to_unsigned(1, 33);
                  IF add_temp_9(32) /= '0' THEN 
                    count_next <= X"FFFFFFFF";
                  ELSE 
                    count_next <= add_temp_9(31 DOWNTO 0);
                  END IF;
                  --
                  -- DATA Stream
                  m_axis_tvalid_reg_next <= '1';
                  m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
                  m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
                  m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
                  m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
                  -- Complete a full block
                  --
                  -- CTRL Stream
                  m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
                  m_axis_ctrl_tlast_reg_next <= '0';
                  m_axis_ctrl_tvalid_reg_next <= '0';
                  --
                  -- STATUS Stream
                  s_axis_status_tready_reg_next <= '1';
                END IF;
              END IF;
            END IF;
          END IF;
        END IF;
      WHEN CTRL =>
        sf_internal_predicateoutput_0 := hdlcoder_to_stdlogic((load AND s_axis_tvalid) = '1');
        IF sf_internal_predicateoutput_0 = '1' THEN 
          state_reg_next <= LOAD_VALID;
          -- Local
          add_temp_1 := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp_1(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp_1(31 DOWNTO 0);
          END IF;
          loaded_n_next <= block_length_unsigned;
          loaded_ctrl_next <= ctrl_word_unsigned;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSIF s_axis_tvalid = '1' THEN 
          state_reg_next <= COUNT_DIN;
          -- Local
          add_temp_4 := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp_4(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp_4(31 DOWNTO 0);
          END IF;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          -- Complete a full block
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSIF ( NOT s_axis_tvalid) = '1' THEN 
          state_reg_next <= WAITING;
          -- Local
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '0';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          -- Local
          add_temp_3 := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp_3(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp_3(31 DOWNTO 0);
          END IF;
          n_next <= loaded_n;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= loaded_ctrl;
          m_axis_ctrl_tlast_reg_next <= '1';
          m_axis_ctrl_tvalid_reg_next <= '1';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        END IF;
      WHEN IDLE =>
        IF load = '1' THEN 
          state_reg_next <= LOAD_NVALID;
          -- Local
          loaded_n_next <= block_length_unsigned;
          loaded_ctrl_next <= ctrl_word_unsigned;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '0';
          m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
          m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
          m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
          m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          sf_internal_predicateoutput_1 := hdlcoder_to_stdlogic((s_axis_tvalid AND hdlcoder_to_stdlogic(count = to_unsigned(0, 32))) = '1');
          IF sf_internal_predicateoutput_1 = '1' THEN 
            state_reg_next <= CTRL;
            -- Local
            add_temp_5 := resize(count, 33) + to_unsigned(1, 33);
            IF add_temp_5(32) /= '0' THEN 
              count_next <= X"FFFFFFFF";
            ELSE 
              count_next <= add_temp_5(31 DOWNTO 0);
            END IF;
            n_next <= loaded_n;
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '1';
            m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
            m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
            m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
            m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= loaded_ctrl;
            m_axis_ctrl_tlast_reg_next <= '1';
            m_axis_ctrl_tvalid_reg_next <= '1';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '1';
          ELSE 
            -- Local
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '0';
            m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
            m_axis_ctrl_tlast_reg_next <= '0';
            m_axis_ctrl_tvalid_reg_next <= '0';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '0';
          END IF;
        END IF;
      WHEN INIT =>
        state_reg_next <= IDLE;
        -- Local
        --
        -- DATA Stream
        m_axis_tvalid_reg_next <= '0';
        m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
        m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
        m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
        m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
        --
        -- CTRL Stream
        m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
        m_axis_ctrl_tlast_reg_next <= '0';
        m_axis_ctrl_tvalid_reg_next <= '0';
        --
        -- STATUS Stream
        s_axis_status_tready_reg_next <= '0';
      WHEN LOAD_NVALID =>
        sf_internal_predicateoutput_2 := hdlcoder_to_stdlogic((s_axis_tvalid AND hdlcoder_to_stdlogic(count = to_unsigned(0, 32))) = '1');
        IF sf_internal_predicateoutput_2 = '1' THEN 
          state_reg_next <= CTRL;
          -- Local
          add_temp_2 := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp_2(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp_2(31 DOWNTO 0);
          END IF;
          n_next <= loaded_n;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= loaded_ctrl;
          m_axis_ctrl_tlast_reg_next <= '1';
          m_axis_ctrl_tvalid_reg_next <= '1';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          b_sf_internal_predicateoutput_0 := hdlcoder_to_stdlogic((s_axis_tvalid AND hdlcoder_to_stdlogic(count > to_unsigned(0, 32))) = '1');
          IF b_sf_internal_predicateoutput_0 = '1' THEN 
            state_reg_next <= COUNT_DIN;
            -- Local
            add_temp_7 := resize(count, 33) + to_unsigned(1, 33);
            IF add_temp_7(32) /= '0' THEN 
              count_next <= X"FFFFFFFF";
            ELSE 
              count_next <= add_temp_7(31 DOWNTO 0);
            END IF;
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '1';
            m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
            m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
            m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
            m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
            -- Complete a full block
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
            m_axis_ctrl_tlast_reg_next <= '0';
            m_axis_ctrl_tvalid_reg_next <= '0';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '1';
          ELSE 
            -- Local
            loaded_n_next <= block_length_unsigned;
            loaded_ctrl_next <= ctrl_word_unsigned;
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '0';
            m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
            m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
            m_axis_ctrl_tlast_reg_next <= '0';
            m_axis_ctrl_tvalid_reg_next <= '0';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '1';
          END IF;
        END IF;
      WHEN LOAD_VALID =>
        IF count < n THEN 
          state_reg_next <= COUNT_DIN;
          -- Local
          add_temp := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp(31 DOWNTO 0);
          END IF;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          -- Complete a full block
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          sf_internal_predicateoutput_3 := hdlcoder_to_stdlogic((hdlcoder_to_stdlogic(count >= n) AND s_axis_tvalid) = '1');
          IF sf_internal_predicateoutput_3 = '1' THEN 
            state_reg_next <= CTRL;
            -- Local
            count_next <= to_unsigned(1, 32);
            n_next <= loaded_n;
            --
            -- DATA Stream
            m_axis_tvalid_reg_next <= '1';
            m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
            m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
            m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
            m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
            --
            -- CTRL Stream
            m_axis_ctrl_tdata_reg_next <= loaded_ctrl;
            m_axis_ctrl_tlast_reg_next <= '1';
            m_axis_ctrl_tvalid_reg_next <= '1';
            --
            -- STATUS Stream
            s_axis_status_tready_reg_next <= '1';
          ELSE 
            b_sf_internal_predicateoutput_1 := hdlcoder_to_stdlogic((hdlcoder_to_stdlogic(count >= n) AND ( NOT s_axis_tvalid)) = '1');
            IF b_sf_internal_predicateoutput_1 = '1' THEN 
              count_next <= to_unsigned(0, 32);
              state_reg_next <= IDLE;
              -- Local
              --
              -- DATA Stream
              m_axis_tvalid_reg_next <= '0';
              m_axis_lane0_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane1_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane2_tdata_reg_next <= to_unsigned(0, 128);
              m_axis_lane3_tdata_reg_next <= to_unsigned(0, 128);
              --
              -- CTRL Stream
              m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
              m_axis_ctrl_tlast_reg_next <= '0';
              m_axis_ctrl_tvalid_reg_next <= '0';
              --
              -- STATUS Stream
              s_axis_status_tready_reg_next <= '0';
            ELSE 
              -- Local
              add_temp_8 := resize(count, 33) + to_unsigned(1, 33);
              IF add_temp_8(32) /= '0' THEN 
                count_next <= X"FFFFFFFF";
              ELSE 
                count_next <= add_temp_8(31 DOWNTO 0);
              END IF;
              loaded_n_next <= block_length_unsigned;
              loaded_ctrl_next <= ctrl_word_unsigned;
              --
              -- DATA Stream
              m_axis_tvalid_reg_next <= '1';
              m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
              m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
              m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
              m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
              --
              -- CTRL Stream
              m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
              m_axis_ctrl_tlast_reg_next <= '0';
              m_axis_ctrl_tvalid_reg_next <= '0';
              --
              -- STATUS Stream
              s_axis_status_tready_reg_next <= '1';
            END IF;
          END IF;
        END IF;
      WHEN OTHERS => 
        --State WAITING
        IF s_axis_tvalid = '1' THEN 
          state_reg_next <= COUNT_DIN;
          -- Local
          add_temp_0 := resize(count, 33) + to_unsigned(1, 33);
          IF add_temp_0(32) /= '0' THEN 
            count_next <= X"FFFFFFFF";
          ELSE 
            count_next <= add_temp_0(31 DOWNTO 0);
          END IF;
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '1';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          -- Complete a full block
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        ELSE 
          -- Local
          --
          -- DATA Stream
          m_axis_tvalid_reg_next <= '0';
          m_axis_lane0_tdata_reg_next <= s_axis_lane0_tdata_unsigned;
          m_axis_lane1_tdata_reg_next <= s_axis_lane1_tdata_unsigned;
          m_axis_lane2_tdata_reg_next <= s_axis_lane2_tdata_unsigned;
          m_axis_lane3_tdata_reg_next <= s_axis_lane3_tdata_unsigned;
          --
          -- CTRL Stream
          m_axis_ctrl_tdata_reg_next <= to_unsigned(0, 32);
          m_axis_ctrl_tlast_reg_next <= '0';
          m_axis_ctrl_tvalid_reg_next <= '0';
          --
          -- STATUS Stream
          s_axis_status_tready_reg_next <= '1';
        END IF;
    END CASE;
  END PROCESS Chart_output;

  m_axis_ctrl_tvalid <= m_axis_ctrl_tvalid_reg_next;
  m_axis_ctrl_tdata_tmp <= m_axis_ctrl_tdata_reg_next;
  m_axis_ctrl_tlast <= m_axis_ctrl_tlast_reg_next;
  m_axis_tvalid <= m_axis_tvalid_reg_next;
  s_axis_status_tready <= s_axis_status_tready_reg_next;
  state <= state_reg_next;
  m_axis_lane0_tdata_tmp <= m_axis_lane0_tdata_reg_next;
  m_axis_lane1_tdata_tmp <= m_axis_lane1_tdata_reg_next;
  m_axis_lane2_tdata_tmp <= m_axis_lane2_tdata_reg_next;
  m_axis_lane3_tdata_tmp <= m_axis_lane3_tdata_reg_next;

  m_axis_ctrl_tdata <= std_logic_vector(m_axis_ctrl_tdata_tmp);

  m_axis_lane0_tdata <= std_logic_vector(m_axis_lane0_tdata_tmp);

  m_axis_lane1_tdata <= std_logic_vector(m_axis_lane1_tdata_tmp);

  m_axis_lane2_tdata <= std_logic_vector(m_axis_lane2_tdata_tmp);

  m_axis_lane3_tdata <= std_logic_vector(m_axis_lane3_tdata_tmp);

END rtl;

