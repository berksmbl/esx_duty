Config                            = {}
Config.DrawDistance               = 5.0
Config.DistanceMethod             = 'LuaMethod'  -- Vdist / LuaMethod
Config.Locale                     = 'tr'

Config.JustCanSeeOne              = true -- If you make this false you can have any zones so near to each other but it will get higher usage

Config.HelpText                   = 'Floating'  -- 3DText / Floating / Normal

Config.Zones = {
  Police  = {
    job = 'police',
    offjob = 'offpolice',
    Pos   = { x = 440.8, y = -981.92, z = 30.63 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
  },

  Ambulance  = {
    job = 'ambulance',
    offjob = 'offambulance',
    Pos = { x = 308.25, y = -592.1, z = 43.23 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  },
  
  Sheriff = {
    job = 'sheriff',
    offjob = 'offsheriff',
    Pos = { x = -450.1, y = 6012.78, z = 31.67 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  }
}
