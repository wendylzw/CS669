-- Create Tables--
CREATE TABLE "Platform" (
  "platform_id" DECIMAL(12) NOT NULL,
  "platform_name" VARCHAR(225) NOT NULL,
  "description" VARCHAR(1024) NOT NULL,
  PRIMARY KEY ("platform_id")
);

CREATE TABLE "Account" (
  "account_id" DECIMAL(12)NOT NULL,
  "account_username" VARCHAR(64)NOT NULL,
  "password" VARCHAR(255)NOT NULL,
  "first_name" VARCHAR(64) NOT NULL,
  "last_name" VARCHAR(64)NOT NULL,
  "email" VARCHAR(255)NOT NULL,
  "created_date" DATE NOT NULL,
  "account_type" CHAR(1)NOT NULL,
  PRIMARY KEY ("account_id")
);


CREATE TABLE "FreeAccount" (
  "account_id" DECIMAL(12)NOT NULL,
  FOREIGN KEY ("account_id") REFERENCES "Account"(account_id)
);


CREATE TABLE "PaidAccount" (
  "account_id" DECIMAL(12)NOT NULL,
  "account_balance" DECIMAL(7,2)NOT NULL,
  "renew_date" DATE NOT NULL,
  FOREIGN KEY ("account_id") REFERENCES "Account"(account_id)
);

CREATE TABLE "VideoWatching" (
  "video_watch_id" DECIMAL(12) NOT NULL,
  "platform_id" DECIMAL(12) NOT NULL,
  "account_id" DECIMAL(12) NOT NULL,
  "watch_date" DATE NOT NULL,
  "watch_time_min" VARCHAR(64) NOT NULL,
  PRIMARY KEY ("video_watch_id") ,
  FOREIGN KEY ("platform_id") REFERENCES "Platform"(platform_id),
  FOREIGN KEY ("account_id") REFERENCES "Account"(account_id)
);


CREATE TABLE "Video" (
  "video_id" DECIMAL(12)NOT NULL,
  "video_watch_id" DECIMAL(12)NOT NULL,
  "video_name" VARCHAR(64)NOT NULL,
  "video_time_min" VARCHAR(64)NOT NULL,
  "director" VARCHAR(100)NOT NULL,
  "video_type" VARCHAR(64)NOT NULL,
  "video_area" VARCHAR(64)NOT NULL,
  PRIMARY KEY ("video_id"),
  FOREIGN KEY ("video_watch_id") REFERENCES "VideoWatching"(video_watch_id)
);


CREATE TABLE "VideoWatchingLink" (
  "link_id" DECIMAL(12)NOT NULL,
  "video_id" DECIMAL(12)NOT NULL,
  "video_watch_id" DECIMAL(12)NOT NULL,
  PRIMARY KEY ("link_id"),
  FOREIGN KEY ("video_watch_id") REFERENCES "VideoWatching"(video_watch_id),
  FOREIGN KEY ("video_id") REFERENCES "Video"(video_id)
);


CREATE TABLE "OnlineWatch" (
  "video_watch_id" DECIMAL(12)NOT NULL,
  "video_watch_url" VARCHAR(1024)NOT NULL,
  FOREIGN KEY ("video_watch_id") REFERENCES "VideoWatching"(video_watch_id)
);

CREATE TABLE "State" (
  "state_id" DECIMAL(12)NOT NULL,
  "state_name" VARCHAR(255)NOT NULL,
  PRIMARY KEY ("state_id")
);


CREATE TABLE "Address" (
  "address_id" DECIMAL(12)NOT NULL,
  "street1" VARCHAR(1024)NOT NULL,
  "street2" VARCHAR(255)NOT NULL,
  "city" VARCHAR(255)NOT NULL,
  "state_id" DECIMAL(12)NOT NULL,
  "postalcode" VARCHAR(64)NOT NULL,
  PRIMARY KEY ("address_id"),
  FOREIGN KEY ("state_id") REFERENCES "State"(state_id)
);



CREATE TABLE "CinemaWatch" (
  "video_watch_id" DECIMAL(12)NOT NULL,
  "address_id" DECIMAL(12)NOT NULL,
  FOREIGN KEY ("video_watch_id") REFERENCES "VideoWatching"(video_watch_id),
  FOREIGN KEY ("address_id") REFERENCES "Address"(address_id)
);


-- Create Index Table --
CREATE INDEX VideoWatching_platform_idx
ON "VideoWatching"(platform_id);

CREATE INDEX VideoWatching_account_idx
ON "VideoWatching"(account_id);

CREATE INDEX CinemaWatch_account_idx
ON "CinemaWatch"(address_id);

CREATE INDEX Address_state_idx
ON "Address"(state_id);

CREATE INDEX VideoWatchingLink_video_idx
ON "VideoWatchingLink"(video_id);

CREATE INDEX VideoWatchingLink_video_watch_idx
ON "VideoWatchingLink"(video_watch_id);





