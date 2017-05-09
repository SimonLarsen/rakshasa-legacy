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
  nextobjectid = 57,
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
          id = 3,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 224,
          y = -48,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -1.33333, y = 128 },
            { x = 0, y = 272 },
            { x = 0, y = 560 }
          },
          properties = {}
        },
        {
          id = 4,
          name = "2",
          type = "Fighter",
          shape = "polyline",
          x = 90,
          y = -46.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -1.33333, y = 128 },
            { x = 0, y = 272 },
            { x = 0, y = 560 }
          },
          properties = {}
        },
        {
          id = 6,
          name = "2",
          type = "Spawner",
          shape = "polyline",
          x = -32,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 384, y = 0 }
          },
          properties = {
            ["count"] = 10,
            ["type"] = "Scout"
          }
        },
        {
          id = 9,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 162,
          y = 142,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "3",
          type = "Turret",
          shape = "rectangle",
          x = 54,
          y = 63.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "3",
          type = "Turret",
          shape = "rectangle",
          x = 273.333,
          y = 60,
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
          id = 22,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 164,
          y = -26.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 74 },
            { x = -1.33333, y = 236 },
            { x = 0, y = 560 }
          },
          properties = {}
        },
        {
          id = 15,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 86,
          y = -25.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 74 },
            { x = -1.33333, y = 236 },
            { x = 0, y = 560 }
          },
          properties = {}
        },
        {
          id = 21,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 239.333,
          y = -26,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -0.666667, y = 74 },
            { x = -1.33333, y = 236 },
            { x = 0, y = 560 }
          },
          properties = {}
        },
        {
          id = 23,
          name = "3",
          type = "Mine",
          shape = "rectangle",
          x = 162,
          y = 190.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "3",
          type = "Drone",
          shape = "polyline",
          x = -35.3333,
          y = 51.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 386.667, y = 122 }
          },
          properties = {}
        },
        {
          id = 32,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = 345.333,
          y = 98.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -364.667, y = 56.6667 }
          },
          properties = {}
        },
        {
          id = 36,
          name = "1",
          type = "Drone",
          shape = "polyline",
          x = -32,
          y = 192,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = -32 },
            { x = 128, y = -32 },
            { x = 128, y = -128 },
            { x = 256, y = -128 },
            { x = 256, y = -32 },
            { x = 384, y = -32 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "wave3",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 38,
          name = "0",
          type = "Falcon",
          shape = "rectangle",
          x = 160,
          y = 94,
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
      name = "wave4",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 43,
          name = "0",
          type = "Spawner",
          shape = "polyline",
          x = -40,
          y = 29.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 311.333, y = 0.666667 },
            { x = 311.333, y = 67.3333 },
            { x = 88, y = 67.3333 },
            { x = 88, y = 131.333 },
            { x = 392, y = 130.667 }
          },
          properties = {
            ["count"] = 4,
            ["delay"] = 0.7,
            ["type"] = "Drone"
          }
        },
        {
          id = 44,
          name = "5",
          type = "Turret",
          shape = "rectangle",
          x = 107.333,
          y = 132.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "3",
          type = "Turret",
          shape = "rectangle",
          x = 228,
          y = 132,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "0",
          type = "Fighter",
          shape = "polyline",
          x = 164,
          y = -42.6667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 88.6667 },
            { x = 0.666667, y = 248 },
            { x = 0, y = 540 }
          },
          properties = {}
        },
        {
          id = 49,
          name = "1",
          type = "Fighter",
          shape = "polyline",
          x = 70.6667,
          y = -44,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 88.6667 },
            { x = 0.666667, y = 248 },
            { x = 0, y = 540 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "wave5",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 50,
          name = "0",
          type = "Falcon",
          shape = "rectangle",
          x = 167.333,
          y = 64,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "0",
          type = "Falcon",
          shape = "rectangle",
          x = 248,
          y = 63.3333,
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
      name = "wave6",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "index",
      properties = {},
      objects = {
        {
          id = 56,
          name = "0",
          type = "LaserSwitch",
          shape = "polyline",
          x = 86,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -78, y = 0 },
            { x = 226, y = 0 }
          },
          properties = {}
        }
      }
    }
  }
}
