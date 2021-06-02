# SlackFetchDiff

Slackで投稿の差分を取得します。チャンネル名やユーザー名の取得もできます。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_fetch_diff'
```


## Usage

```ruby
token = 'slackのtoken'
cache_dir = '/tmp/slack_fetch_diff/cache'

slack_fetch_diff = SlackFetchDiff.new(token: token, cache_dir: cache_dir)

# チャンネルの一覧
# チャンネル名とチャンネルIDのhash
slack_fetch_diff.channel_list

# チャンネルの投稿を取得
# 前回取得時からの差分を返す
slack_fetch_diff.fetch_messages(channel_id)

# ユーザー名を取得する
slack_fetch_diff.user_name_by(user_id)

# bot名を取得する
slack_fetch_diff.bot_name_by(user_id)

```
