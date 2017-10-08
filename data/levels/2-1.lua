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
  nextobjectid = 57,
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
          id = 35,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 80, y = 0 }
          },
          properties = {}
        },
        {
          id = 36,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 304,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -80, y = 0 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "2",
          type = "Silo",
          shape = "polyline",
          x = 352,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -384, y = 0 }
          },
          properties = {
            ["speed"] = 140
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 14,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 128,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = -16, y = 0 },
            { x = 80, y = 0 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "0.2",
          type = "Fighter",
          shape = "polyline",
          x = 272,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 },
            { x = 0, y = 240 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 15,
          name = "0.1",
          type = "Fighter",
          shape = "polyline",
          x = 48,
          y = -32,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 0, y = 128 },
            { x = 0, y = 240 },
            { x = 0, y = 544 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "2.5",
          type = "Laser",
          shape = "polyline",
          x = 16,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 80, y = 0 }
          },
          properties = {}
        },
        {
          id = 18,
          name = "0",
          type = "Laser",
          shape = "polyline",
          x = 304,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -80, y = 0 }
          },
          properties = {}
        },
        {
          id = 25,
          name = "1",
          type = "Bunker",
          shape = "rectangle",
          x = 160,
          y = 144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "0.32",
          type = "Bunker",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "0",
          type = "Bunker",
          shape = "rectangle",
          x = 192,
          y = 128,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "1",
          type = "Turret",
          shape = "rectangle",
          x = 160,
          y = 64,
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
      name = "3",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 56,
          name = "0",
          type = "LaserTurret",
          shape = "rectangle",
          x = 160,
          y = 96,
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
