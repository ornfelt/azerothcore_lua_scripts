use characters;
CREATE TABLE xprates (
    guid INT(10) unsigned NOT NULL,
    rate int(10) unsigned NOT NULL DEFAULT '1',
    maxRate INT(10) unsigned NOT NULL DEFAULT '7',
    PRIMARY KEY (guid)
)