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
  nextobjectid = 49,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "Object Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 45,
          name = "0",
          type = "laser",
          shape = "polyline",
          x = 70.5,
          y = 45.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 80 }
          },
          properties = {}
        },
        {
          id = 46,
          name = "4",
          type = "laser",
          shape = "polyline",
          x = 174.5,
          y = 82,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 96, y = 0 }
          },
          properties = {}
        },
        {
          id = 48,
          name = "4",
          type = "laser",
          shape = "polyline",
          x = 127,
          y = 220.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 64, y = -64 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "Object Layer 2",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 15,
          name = "2",
          type = "durga",
          shape = "rectangle",
          x = 69.3333,
          y = 36.6667,
          width = 185.333,
          height = 106.667,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
