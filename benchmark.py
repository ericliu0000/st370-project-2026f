import math
import time
from typing import Dict, List
import numpy as np
from threadpoolctl import threadpool_limits


DESIGN_SPECS: Dict[int, Dict] = {
    500000: {
        "log_size": 5.699,
        "n_dim": round(math.sqrt(500000)),  # 707 -> 499,849 elements
        "threads": {
            2: [63, 81, 29, 30, 33, 53],
            3: [47, 51, 64, 59, 65, 36],
            4: [46, 69, 34, 21, 54, 16],
            6: [75, 10, 13, 27, 6, 72],
        },
    },
    1000000: {
        "log_size": 6.0,
        "n_dim": round(math.sqrt(1000000)),  # 1000 -> 1,000,000 elements
        "threads": {
            2: [19, 70, 50, 61, 44, 40],
            3: [87, 76, 9, 11, 96, 43],
            4: [26, 83, 93, 78, 28, 90],
            6: [3, 18, 82, 42, 73, 56],
        },
    },
    2000000: {
        "log_size": 6.301,
        "n_dim": round(math.sqrt(2000000)),  # 1414 -> 1,999,396 elements
        "threads": {
            2: [95, 41, 15, 12, 71, 80],
            3: [92, 55, 38, 48, 68, 85],
            4: [49, 79, 66, 74, 84, 91],
            6: [58, 57, 88, 94, 22, 23],
        },
    },
    5000000: {
        "log_size": 6.699,
        "n_dim": round(math.sqrt(5000000)),  # 2236 -> 4,999,696 elements
        "threads": {
            2: [5, 86, 39, 25, 14, 7],
            3: [31, 77, 37, 24, 4, 2],
            4: [62, 45, 35, 52, 17, 67],
            6: [1, 20, 89, 32, 60, 8],
        },
    },
}


def build_trial_schedule() -> List[Dict]:
    trials = {}
    for size, sdata in DESIGN_SPECS.items():
        log_size = sdata["log_size"]
        n_dim = sdata["n_dim"]
        for th, run_orders in sdata["threads"].items():
            for replication, n in enumerate(run_orders, start=1):
                if n in trials:
                    raise ValueError(f"Duplicate run_order detected: {n}")
                trials[n] = {
                    "run_order": n,
                    "size": size,
                    "n_dim": n_dim,
                    "log_size": log_size,
                    "threads": th,
                    "replicate": replication,
                }

    return [trials[i] for i in sorted(trials.keys())]


def run_experiment() -> List[Dict]:
    schedule = build_trial_schedule()
    results = []

    for trial in schedule:
        n_dim = trial["n_dim"]
        threads = trial["threads"]

        A = np.random.randn(n_dim, n_dim).astype(np.float64)
        B = np.random.randn(n_dim, n_dim).astype(np.float64)
        C = np.empty((n_dim, n_dim), dtype=np.float64)

        with threadpool_limits(limits=threads, user_api="blas"):
            t0 = time.perf_counter()
            np.matmul(A, B, out=C)
            t1 = time.perf_counter()

        elapsed = t1 - t0

        trial_record = {
            "run_order": trial["run_order"],
            "size": trial["size"],
            "n_dim": n_dim,
            "log_size": trial["log_size"],
            "threads": threads,
            "replicate": trial["replicate"],
            "time_seconds": elapsed,
        }

        print(trial_record)
        results.append(trial_record)

    with open(f"{int(time.time())}.txt", mode="w", encoding="utf-8") as f:
        f.write("@ time log_size threads run_order rep size\n")
        for r in results:
            f.write(
                f"{r['time_seconds']:.6f} {r['log_size']:.3f} {r['threads']} "
                f"{r['run_order']} {r['replicate']} {r['size']}\n"
            )


if __name__ == "__main__":
    run_experiment()

