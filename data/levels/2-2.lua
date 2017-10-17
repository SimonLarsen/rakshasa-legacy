return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 9,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 8,
          name = "0",
          type = "LaserSwitch",
          shape = "polyline",
          x = 16,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 288, y = 0 }
          },
          properties = {}
        }
      }
    }
  }
}
