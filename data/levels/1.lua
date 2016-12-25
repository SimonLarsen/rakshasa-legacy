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
  nextobjectid = 270,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "wave0",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 269,
          name = "0",
          type = "Falcon",
          shape = "rectangle",
          x = 170.184,
          y = 103.853,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "wave1",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 260,
          name = "0",
          type = "Viper",
          shape = "polyline",
          x = 79.4908,
          y = -17.34,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = -16 },
            { x = -1.34003, y = 122.399 },
            { x = -1.34003, y = 240.509 },
            { x = 0, y = 528 }
          },
          properties = {}
        },
        {
          id = 261,
          name = "1",
          type = "Viper",
          shape = "polyline",
          x = 246.566,
          y = -18.7605,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = -16 },
            { x = -1.34003, y = 122.399 },
            { x = -1.34003, y = 240.509 },
            { x = 0, y = 528 }
          },
          properties = {}
        },
        {
          id = 262,
          name = "1",
          type = "Spawner",
          shape = "polyline",
          x = -35.5109,
          y = 124.623,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 143.384, y = 0 },
            { x = 251.256, y = 94.4724 },
            { x = 391.29, y = 94.4724 }
          },
          properties = {
            ["count"] = 10,
            ["type"] = "Scout"
          }
        },
        {
          id = 264,
          name = "1",
          type = "Temple",
          shape = "rectangle",
          x = 174.874,
          y = 141.374,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 267,
          name = "2",
          type = "Turret",
          shape = "rectangle",
          x = 45.5611,
          y = 191.625,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 268,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 263.987,
          y = 143.384,
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
