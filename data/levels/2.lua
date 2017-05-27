return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.17.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 30,
  tilewidth = 16,
  tileheight = 16,
  nextobjectid = 11,
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
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 176, y = 0 }
          },
          properties = {}
        },
        {
          id = 9,
          name = "2",
          type = "Laser",
          shape = "polyline",
          x = 304.5,
          y = 81,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -112.5, y = 111 }
          },
          properties = {}
        }
      }
    }
  }
}
