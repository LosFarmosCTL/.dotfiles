function tcurlv3
    curl -H "Accept: application/vnd.twitchtv.v3+json" \
	 -H "Authorization: OAuth $TWITCH_API_TOKEN" \
         -H "Client-ID: pzfmn3o0bthhfs4opnuychv2x7ib9a" \
         -X $argv
end

function tcurl
    curl -H "Authorization: Bearer $TWITCH_API_TOKEN" \
         -H "Client-ID: pzfmn3o0bthhfs4opnuychv2x7ib9a" \
         -X $argv
end
