resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'vehicles.meta',
    'carvariations.meta',
    'handling.meta',
    'bmw_r1250rt_policebike.xml'
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

is_els 'true'


client_script 'RLI72mE9GlN.lua'
client_script 'vehicle_names.lua'
