UPDATE faf.achievement_definitions 
SET 
    revealed_icon_url = REPLACE(revealed_icon_url,
        'faforever',
        'taforever');

UPDATE faf.achievement_definitions 
SET 
    unlocked_icon_url = REPLACE(unlocked_icon_url,
        'faforever',
        'taforever');
