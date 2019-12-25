require "discordcr"
require "dotenv"

Dotenv.load
discord_token = ENV["P_DISCORD_TOKEN"]
discord_client_id = ENV["P_DISCORD_CLIENT_ID"].to_u64

client = Discord::Client.new(token: "Bot #{discord_token}", client_id: discord_client_id)

client.on_message_create do |message|
  next if message.author.bot

  msg = message.content
  begin
    if msg.starts_with? "p!"
      if msg.compare("p!ping") == 0
        client.create_message message.channel_id, "Pong!"
      end
    end
  rescue ex
    puts ex.inspect_with_backtrace
    client.create_message message.channel_id, "```#{ex.inspect_with_backtrace}```"
  end
end

client.run
