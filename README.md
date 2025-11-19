# Single Furnace Stack

Single Furnace Stack adds tiered furnace items, entities and smelting recipes keyed to belt throughput. It supports vanilla, Space Age and Krastorio 2 integrations.

Quick references:

- Mod manifest: [info.json](info.json)
- Main data loader: [data.lua](data.lua)
- Recipe creation: [`prototypes/smelting-recipe-creation.lua`](prototypes/smelting-recipe-creation.lua)
- Furnace creation: [`prototypes/create-furnaces.lua`](prototypes/create-furnaces.lua)
- Settings: [`settings.lua`](settings.lua)
- Guidance for adding content: [AddingContent.md`](AddingContent.md)

Installation

1. Copy the mod folder into Factorio's `mods/` directory.
2. Launch Factorio and enable the mod.

Adding content

- See [How to Add Content.,md](How to Add Content.,md) for steps to add belt tiers or processing recipes.
- Define new belt tiers by adding entries to the appropriate `prototypes/*/belt-tiers.lua` (vanilla, space-age, krastorio).
- Add processing recipes to `prototypes/*/processing-recipes.lua` and let `prototypes/smelting-recipe-creation.lua` generate tiered recipes.

Localization

- Localization files are in `locale/en/` (e.g. [locale/en/recipe-name.cfg](locale/en/recipe-name.cfg)).

License

- This project is licensed under GPL-3.0. See [LICENSE](LICENSE).
