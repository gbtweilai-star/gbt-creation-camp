# creation_camp

**One capability bit from GBT V8, packaged standalone.** No. 25 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 创造营编排（「AI 视觉创造营」形式蒸馏）：**主题 → 逐日营计划**——7 天基准节奏（开营定题→采样风格→构图分镜→批量出图→修饰选片→编排成片→展陈复盘），每天三件（任务/产出物/验收点）。**零网络零 LLM**（确定性）；点名的能力位**现读注册表**，缺的落「缺口」（幽灵能力红）；视觉工具**只引用现成位、不重造**。op=sources/caps/plan/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-creation-camp.git
cd gbt-creation-camp
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_creation_camp info                  # capability card
python -m gbt_creation_camp spec --json           # machine-readable contract
python -m gbt_creation_camp check --payload '{}'
python -m gbt_creation_camp run   --payload '{}'
```

Real `info` output from this machine:

```text
creation_camp  (creation)  v1.0.0
----------------------------------------
创造营编排（「AI 视觉创造营」形式蒸馏）：**主题 → 逐日营计划**——7 天基准节奏（开营定题→采样风格→构图分镜→批量出图→修饰选片→编排成片→展陈复盘），每天三件（任务/产出物/验收点）。**零网络零 LLM**（确定性）；点名的能力位**现读注册表**，缺的落「缺口」（幽灵能力红）；视觉工具**只引用现成位、不重造**。op=sources/caps/plan/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : sources, caps, plan, where
```

Wire a real implementation:

```python
from gbt_creation_camp import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（4 个）**：`sources`、`caps`、`plan`、`where`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.15s
```

## Provenance

| field | value |
|---|---|
| capability | `creation_camp` |
| domain | `creation` |
| handler | `creation_camp` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [creation/creation_camp](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/creation_camp.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
