# ~/.config/fish/conf.d/yt-dlp.fish

if status is-interactive

    function youtube
        yt-dlp $argv
    end

end