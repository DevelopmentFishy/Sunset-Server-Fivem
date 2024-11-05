CREATE TABLE IF NOT EXISTS `insta_stories` (
  `username` varchar(50),
  `location` varchar(50),
  `filter` varchar(50),
  `description` varchar(50),
  `image` text,
  `created` time
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `instagram_stories` (
  `owner` varchar(50),
  `data` text,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = armscii8;

CREATE TABLE IF NOT EXISTS `instagram_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text,
  `description` text,
  `verify` INT(11) NOT NULL DEFAULT '0'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `instagram_followers` (
  `username` varchar(50) NOT NULL,
  `followed` varchar(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `instagram_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `description` varchar(255) NOT NULL,
  `location` varchar(50) NOT NULL DEFAULT 'Los Santos',
  `filter` varchar(50) NOT NULL,
  `created` timestamp NOT NULL,
  `likes` TEXT,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(50) NULL,
  `citizenid` varchar(50) DEFAULT NULL, 
  `sender` VARCHAR(50) NULL,
  `subject` VARCHAR(50) NULL,
  `message` TEXT NULL,
  `read` TINYINT(4) NULL,
  `mailid` INT(11) NULL,
  `date` TIMESTAMP NULL DEFAULT current_timestamp(),
  `button` TEXT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier` (`identifier`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2;

CREATE TABLE IF NOT EXISTS `tinder_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `gender` varchar(50) NOT NULL,
  `targetGender` varchar(50) NOT NULL DEFAULT '0',
  `hobbies` varchar(50) NOT NULL DEFAULT '0',
  `age` varchar(50) NOT NULL DEFAULT '0',
  `description` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 17 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `tinder_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(1024) NOT NULL,
  `likeds` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS `phone_accounts` (
  `app` varchar(50) NOT NULL,
  `id` varchar(80) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `birthdate` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `interested` text NOT NULL,
  `avatar` text NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_chats` (
  `app` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(46) DEFAULT NULL,
  `phone` varchar(50),
  `number` varchar(50) NOT NULL,
  `owner` varchar(50),
  `messages` text NOT NULL,
  `type` varchar(50),
  `read` int(11),
  `created` varchar(50),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 20 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_notifies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `msg_content` text NOT NULL,
  `msg_head` varchar(50) NOT NULL DEFAULT '',
  `app_name` text NOT NULL,
  `msg_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 64 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(50) NULL DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL, 
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `number` VARCHAR(50) NULL DEFAULT NULL,
  `iban` VARCHAR(50) NOT NULL DEFAULT '0',
  `display` VARCHAR(50),
  `note` TEXT NOT NULL,
  `pp` TEXT NOT NULL,
  `isBlocked` INT(11) NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `identifier` (`identifier`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38;

CREATE TABLE IF NOT EXISTS `player_gallery` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` TEXT NOT NULL,
  `resim` TEXT NOT NULL,
  `data` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11;

CREATE TABLE IF NOT EXISTS `tinder_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` longtext NOT NULL,
  `messages` longtext DEFAULT '{}',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11;

CREATE TABLE IF NOT EXISTS `twitter_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `avatar` text NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `twitter_hashtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `created` varchar(50) NOT NULL,
  `count` int(11) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `twitter_mentions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tweet` INT(11) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `mentioned` TEXT NOT NULL,
  `created` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4;

CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `message` longtext NOT NULL,
  `hashtags` varchar(50) NOT NULL,
  `mentions` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `likes` TEXT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `whatsapp_accounts` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `whatsapp_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `messages` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 43 DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `whatsapp_chats_messages`;
CREATE TABLE IF NOT EXISTS `whatsapp_chats_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `readed` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS `whatsapp_groups` (
  `id` int(11) AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4;

DROP TABLE IF EXISTS `whatsapp_groups_messages`;
CREATE TABLE IF NOT EXISTS `whatsapp_groups_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_group` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `read` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `whatsapp_groups_users` (
  `number_group` varchar(50) NOT NULL,
  `admin` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `player_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `baslik` text NOT NULL,
  `aciklama` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `whatsapp_stories` (
  `phone` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `description` varchar(50),
  `location` varchar(50),
  `filter` varchar(50)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `darkchat_messages` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `password` text NOT NULL,
  `owner` VARCHAR(50) NULL DEFAULT NULL,
  `name` VARCHAR(50) NULL DEFAULT '',
  `messages` TEXT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id` (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10;

CREATE TABLE IF NOT EXISTS `phone_alertjobs` (
  `id` int(11) NOT NULL,
  `job` varchar(255) NOT NULL,
  `alerts` longtext NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `yellowpages_posts` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `message` TEXT,
    `name` VARCHAR(255),
    `number` VARCHAR(20),
    `url` VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS `phone_news` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `owner` VARCHAR(50) NULL DEFAULT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `content` TEXT NULL,
  `image` TEXT NULL,
  `created` VARCHAR(50) NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
)  ENGINE=InnoDB AUTO_INCREMENT=5;

CREATE TABLE IF NOT EXISTS `tiktok_users` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL DEFAULT '0',
    `phone` VARCHAR(50) NOT NULL DEFAULT '0',
    `pp` TEXT NULL,
    `name` VARCHAR(50) NOT NULL DEFAULT '0',
    `bio` TEXT NOT NULL DEFAULT '',
    `birthday` VARCHAR(50) NOT NULL DEFAULT '0',
    `videos` TEXT NOT NULL DEFAULT '{}',
    `followers` TEXT NOT NULL,
    `following` TEXT NOT NULL,
    `liked` TEXT NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13;

CREATE TABLE IF NOT EXISTS `tiktok_videos` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `userID` INT(11) NULL DEFAULT NULL,
    `created` VARCHAR(50) NOT NULL DEFAULT '00:00:00',
    `data` TEXT NULL,
    `phone` VARCHAR(50) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=440;

INSERT INTO `phone_chatrooms` (`room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `is_pinned`) VALUES
  ('social', 'Social', 'official', 'Government', 1),
  ('lounge', 'The Lounge', 'official', 'Government', 1),
  ('events', 'Events', 'official', 'Government', 1);

ALTER TABLE `phone_alertjobs` ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `job` (`job`);

ALTER TABLE `phone_alertjobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

ALTER TABLE whatsapp_groups_messages CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE whatsapp_groups_users CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE whatsapp_accounts CONVERT TO CHARACTER SET utf8mb4;
ALTER TABLE whatsapp_chats_messages CONVERT TO CHARACTER SET utf8mb4;