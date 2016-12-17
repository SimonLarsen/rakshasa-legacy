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
  nextobjectid = 260,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "wave1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 258,
          name = "0",
          type = "Dropship",
          shape = "polyline",
          x = -32,
          y = 112,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -16, y = 0 },
            { x = 208, y = 0 },
            { x = 400, y = 0 }
          },
          properties = {}
        },
        {
          id = 259,
          name = "2",
          type = "Falcon",
          shape = "rectangle",
          x = 169.333,
          y = 129.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
