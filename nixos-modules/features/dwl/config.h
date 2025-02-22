/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)                                                             \
  {((hex >> 24) & 0xFF) / 255.0f, ((hex >> 16) & 0xFF) / 255.0f,               \
   ((hex >> 8) & 0xFF) / 255.0f, (hex & 0xFF) / 255.0f}
/* appearance */
static const int sloppyfocus = 0; /* focus follows mouse */
/* 1 means idle inhibitors will disable idle tracking even if it's surface isn't
 * visible*/
static const int bypass_surface_visibility = 0;
static const unsigned int borderpx = 2;    /* border pixel of windows */
static const int draw_minimal_borders = 1; /* merge adjacent borders */
static const float rootcolor[] = COLOR(0x222222ff);
static const float bordercolor[] = COLOR(0x444444ff);
static const float focuscolor[] = COLOR(0x005577ff);
static const float urgentcolor[] = COLOR(0xff0000ff);
/* 1 to monitor center while respecting the monitor's reserved area, 0 to
 * monitor center */
static const int respect_monitor_reserved_area = 1;
/* This conforms to the xdg-protocol. Set the alpha to zero to restore the old
 * behavior */
/* You can also use glsl colors */
static const float fullscreen_bg[] = {0.1f, 0.1f, 0.1f, 0.1f};

/* tagging - TAGCOUNT must be no greater than 31 */
#define TAGCOUNT (9)

/* logging */
static int log_level = WLR_ERROR;

/* Autostart */
static const char *const autostart[] = {"systemctl", "start", "--user",
                                        "window-manager.target", NULL, NULL};

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at
 * least one example) */
static const Rule rules[] = {
    /* app_id title tags mask isfloating monitor x y width height */
    {"example", NULL, 0, 0, -1, 0, 0, 0, 0},
};

/* layout(s) */
static const Layout layouts[] = {
    /* symbolarrange function */
    {"[]=", tile},
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland
 * clients https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
 */
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be
 * used */
static const MonitorRule monrules[] = {
    /* namemfactnmaster scale layoutrotate/reflect xy */
    /* defaults */
    {NULL, 0.5f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1},
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
    /* can specify fields: rules, model, layout, variant, options */
    /* example:
    .options = "ctrl:nocaps",
    */
    .options = NULL,
};

static const int repeat_rate = 25;
static const int repeat_delay = 300;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method =
    LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method =
    LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode =
    LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile =
    LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map =
    LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO
#define MOVE_MODKEY MODKEY | WLR_MODIFIER_SHIFT
#define SIZE_MODKEY MODKEY | WLR_MODIFIER_CTRL
#define MODE_MODKEY MODKEY | WLR_MODIFIER_ALT

#define TAGKEYS(KEY, SKEY, TAG)                                                \
  {MODKEY, KEY, view, {.ui = 1 << TAG}}, {                                     \
    MOVE_MODKEY, SKEY, tag, { .ui = 1 << TAG }                                 \
  }

/* modes */
enum { QUIT };
const char *modes_labels[] = {"quit"};

/* commands */
static const char *termcmd[] = {"alacritty", NULL};
static const char *suspend[] = {"suspend", NULL};
static const char *reboot[] = {"reboot", NULL};
static const char *poweroff[] = {"poweroff", NULL};

static const Key keys[] = {
    /* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
    /* modifier key function argument */
    {MODKEY, XKB_KEY_Return, spawn, {.v = termcmd}},

    {MODKEY, XKB_KEY_h, focusdir, {.ui = 0}},
    {MODKEY, XKB_KEY_l, focusdir, {.ui = 1}},
    {MODKEY, XKB_KEY_j, focusdir, {.ui = 2}},
    {MODKEY, XKB_KEY_k, focusdir, {.ui = 3}},
    {MOVE_MODKEY, XKB_KEY_H, swapdir, {.ui = 0}},
    {MOVE_MODKEY, XKB_KEY_L, swapdir, {.ui = 1}},
    {MOVE_MODKEY, XKB_KEY_J, swapdir, {.ui = 2}},
    {MOVE_MODKEY, XKB_KEY_K, swapdir, {.ui = 3}},
    {SIZE_MODKEY, XKB_KEY_h, setmfact, {.f = -0.01f}},
    {SIZE_MODKEY, XKB_KEY_l, setmfact, {.f = +0.01f}},

    {MODKEY, XKB_KEY_q, killclient, {0}},
    {MODKEY, XKB_KEY_space, togglefloating, {0}},
    {MODKEY, XKB_KEY_f, togglefullscreen, {0}},

    TAGKEYS(XKB_KEY_1, XKB_KEY_exclam, 0),
    TAGKEYS(XKB_KEY_2, XKB_KEY_at, 1),
    TAGKEYS(XKB_KEY_3, XKB_KEY_numbersign, 2),
    TAGKEYS(XKB_KEY_4, XKB_KEY_dollar, 3),
    TAGKEYS(XKB_KEY_5, XKB_KEY_percent, 4),
    TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
    TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand, 6),
    TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk, 7),
    TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft, 8),

    {MODE_MODKEY, XKB_KEY_q, entermode, {.i = QUIT}},

/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
 * do not remove them.
 */
#define CHVT(n)                                                                \
  {                                                                            \
    WLR_MODIFIER_CTRL | WLR_MODIFIER_ALT, XKB_KEY_XF86Switch_VT_##n, chvt, {   \
      .ui = (n)                                                                \
    }                                                                          \
  }
    CHVT(1),
    CHVT(2),
    CHVT(3),
    CHVT(4),
    CHVT(5),
    CHVT(6),
    CHVT(7),
    CHVT(8),
    CHVT(9),
    CHVT(10),
    CHVT(11),
    CHVT(12),
};

static const Modekey modekeys[] = {
    {QUIT, {0, XKB_KEY_s, spawn, {.v = suspend}}},
    {QUIT, {0, XKB_KEY_s, entermode, {.i = NORMAL}}},
    {QUIT, {0, XKB_KEY_r, spawn, {.v = reboot}}},
    {QUIT, {0, XKB_KEY_p, spawn, {.v = poweroff}}},
    {QUIT, {0, XKB_KEY_q, quit, {0}}},

    {QUIT, {0, XKB_KEY_Escape, entermode, {.i = NORMAL}}},
};

static const Button buttons[] = {
    {MODKEY, BTN_LEFT, moveresize, {.ui = CurMove}},
    {MODKEY, BTN_RIGHT, moveresize, {.ui = CurResize}},
};
