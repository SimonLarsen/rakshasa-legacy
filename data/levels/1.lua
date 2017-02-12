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
  nextobjectid = 301,
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
          id = 299,
          name = "0",
          type = "Scout",
          shape = "polyline",
          x = 96,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 144 },
            { x = 0, y = 256 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 300,
          name = "1",
          type = "Scout",
          shape = "polyline",
          x = 240,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 },
            { x = 0, y = 272 },
            { x = 0, y = 544 }
          },
          properties = {}
        }
      }
    }
  }
}
