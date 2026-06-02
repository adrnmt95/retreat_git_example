import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from pathlib import Path

# ── Paths ──────────────────────────────────────────────────────────────
DATA_PATH = Path(__file__).parents[1] / "data" / "2010-01-01-2024-05-01-Middle_East-Israel-Palestine.csv"
FIG_DIR   = Path(__file__).parents[1] / "paper" / "figures"
FIG_DIR.mkdir(parents=True, exist_ok=True)

# ── Bounding boxes ─────────────────────────────────────────────────────
# Gaza Strip
GAZA_LAT  = (31.22, 31.60)
GAZA_LON  = (34.20, 34.60)

# West Bank
WB_LAT    = (31.30, 32.60)
WB_LON    = (34.85, 35.60)

VIOLENT_TYPES = [
    "Battles",
    "Explosions/Remote violence",
    "Violence against civilians",
    "Riots",
]

# ── Load & filter ──────────────────────────────────────────────────────
df = pd.read_csv(DATA_PATH, parse_dates=["event_date"], dayfirst=True)
df = df[df["country"] == "Palestine"].copy()
df = df[df["event_type"].isin(VIOLENT_TYPES)].copy()

def in_bbox(df, lat_range, lon_range):
    return df[
        df["latitude"].between(*lat_range) &
        df["longitude"].between(*lon_range)
    ]

gaza = in_bbox(df, GAZA_LAT, GAZA_LON)
wb   = in_bbox(df, WB_LAT,   WB_LON)

# ── Daily counts & 7-day moving average ───────────────────────────────
def daily_ma(subset):
    daily = subset.groupby("event_date").size().rename("events")
    # fill missing days with 0
    full_idx = pd.date_range(daily.index.min(), daily.index.max(), freq="D")
    daily = daily.reindex(full_idx, fill_value=0)
    daily.index.name = "date"
    ma = daily.rolling(7, center=True, min_periods=1).mean()
    return daily, ma

gaza_daily, gaza_ma = daily_ma(gaza)
wb_daily,   wb_ma   = daily_ma(wb)

# ── Plot styling ───────────────────────────────────────────────────────
plt.rcParams.update({
    "font.family":   "serif",
    "font.size":     11,
    "axes.spines.top":   False,
    "axes.spines.right": False,
})

REGION_CFG = [
    ("Gaza Strip",  gaza_daily, gaza_ma, "#c0392b", "figures/ts_gaza.pdf"),
    ("West Bank",   wb_daily,   wb_ma,   "#2980b9", "figures/ts_westbank.pdf"),
]

for title, daily, ma, color, rel_path in REGION_CFG:
    fig, ax = plt.subplots(figsize=(10, 4))

    ax.bar(daily.index, daily.values, color=color, alpha=0.25, width=1,
           label="Daily events", zorder=2)
    ax.plot(ma.index, ma.values, color=color, linewidth=1.8,
            label="7-day moving average", zorder=3)

    ax.xaxis.set_major_locator(mdates.YearLocator())
    ax.xaxis.set_major_formatter(mdates.DateFormatter("%Y"))
    ax.xaxis.set_minor_locator(mdates.MonthLocator(bymonth=[4, 7, 10]))
    fig.autofmt_xdate(rotation=0, ha="center")

    ax.set_title(f"Violent Events — {title}", fontsize=13, fontweight="bold", pad=10)
    ax.set_ylabel("Number of events")
    ax.set_xlabel("")
    ax.legend(frameon=False, fontsize=10)
    ax.margins(x=0.01)

    out = FIG_DIR / Path(rel_path).name
    fig.tight_layout()
    fig.savefig(out, dpi=200, bbox_inches="tight")
    print(f"Saved: {out}")
    plt.close(fig)

print("Done.")
