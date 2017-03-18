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
  nextobjectid = 340,
  properties = {},
  tilesets = {},
  layers = {
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
          id = 299,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 96,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0.666667, y = 99.3333 },
            { x = 0, y = 244.667 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 302,
          name = "0.5",
          type = "Spawner",
          shape = "polyline",
          x = -32,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 192, y = 0 },
            { x = 192, y = 112 },
            { x = 384, y = 112 }
          },
          properties = {
            ["count"] = 10,
            ["type"] = "Scout"
          }
        },
        {
          id = 300,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 240,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 132.667 },
            { x = 0, y = 276.667 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 303,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 80,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 305,
          name = "0",
          type = "Turret",
          shape = "rectangle",
          x = 256,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 307,
          name = "2",
          type = "Temple",
          shape = "rectangle",
          x = 175.333,
          y = 82.6667,
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
      name = "wave2",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 315,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 289.333,
          y = 167.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -144, y = 0 }
          },
          properties = {}
        },
        {
          id = 322,
          name = "1.5",
          type = "SuperMine",
          shape = "rectangle",
          x = 86.8333,
          y = 214.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 60
          }
        },
        {
          id = 319,
          name = "2.5",
          type = "Laser",
          shape = "polyline",
          x = 177.333,
          y = 199.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -144, y = 0 }
          },
          properties = {}
        },
        {
          id = 323,
          name = "1.5",
          type = "SuperMine",
          shape = "rectangle",
          x = 236.833,
          y = 216.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 60
          }
        },
        {
          id = 320,
          name = "2.5",
          type = "Laser",
          shape = "polyline",
          x = 292.333,
          y = 230.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -144, y = 0 }
          },
          properties = {}
        },
        {
          id = 324,
          name = "1.5",
          type = "SuperMine",
          shape = "rectangle",
          x = 86.5,
          y = 214.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 60
          }
        },
        {
          id = 325,
          name = "0",
          type = "SuperMine",
          shape = "rectangle",
          x = 237.667,
          y = 216.167,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = 60
          }
        },
        {
          id = 321,
          name = "2.5",
          type = "Laser",
          shape = "polyline",
          x = 177.333,
          y = 263.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -144, y = 0 }
          },
          properties = {}
        },
        {
          id = 333,
          name = "1",
          type = "Dropship",
          shape = "polyline",
          x = -39.3333,
          y = 26,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 147.333, y = 40.6667 },
            { x = 387.333, y = 124 }
          },
          properties = {}
        },
        {
          id = 334,
          name = "1",
          type = "Dropship",
          shape = "polyline",
          x = 344,
          y = 42.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -145.333, y = 32 },
            { x = -386, y = 110 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "wave3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 339,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 224,
          y = 32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 48, y = 96 },
            { x = -96, y = 96 }
          },
          properties = {
            ["intervals"] = "1,1"
          }
        }
      }
    }
  }
}
