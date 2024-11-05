fx_version 'cerulean'
games {'gta5'}

this_is_a_map 'yes'
version '1.0.2'

files {
  'audio/v_diables_hopital_col_game.dat151.rel',
  'audio/v_diables_hopital_col_mix.dat15.rel',
  'audio/v_diables_hopital_col_part2_game.dat151.rel',
  'audio/v_diables_hopital_col_part2_mix.dat15.rel',
}

escrow_ignore {
  'stream/interior/props/v_diables_hopital_tableau_01.ydr',
  'stream/interior/props/v_diables_hopital_tableau_02.ydr',
  'stream/interior/props/v_diables_hopital_tableau_03.ydr',
  'stream/interior/props/v_diables_hopital_tableau_04.ydr'
}

data_file 'AUDIO_GAMEDATA' 'audio/v_diables_hopital_col_game.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/v_diables_hopital_col_mix.dat'
data_file 'AUDIO_GAMEDATA' 'audio/v_diables_hopital_col_part2_game.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/v_diables_hopital_col_part2_mix.dat'

data_file 'DLC_ITYP_REQUEST' 'stream/interior/ytyp/v_diables_hopital.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/interior/part2/v_diables_hopital_part2.ytyp'
dependency '/assetpacks'