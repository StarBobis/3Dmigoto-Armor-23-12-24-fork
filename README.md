# 3Dmigoto-Armor
Latest fork date: 2023-12-24

To keep update with original 3Dmigoto project,these fork version of 3Dmigoto-Armor series project will show 
the fork date in project name ,so you can know what latest features it include and what not.

This fork is mainly to solve the game mod problem.
# Core problem about VertexLimitRaise
Currently we use 40(POSITION_12 + NORMAL_12 + TANGENT_16) as default vertex buffer size for a single vertex,
but this may change in UE games,because UE game's d3d11 element bytewidth is totally different,so you may need to change
the 40 magic value in code to fit your game. 

# Features
- Dynamic d3d11 desc byte increase with model's vertex number to avoid memory waste and avoid possible out of memory error.
- Increase default d3d11 desc byte width to 380k(380 * 1000 * 40) as GIMI's design.
- Compatible with GIMI's d3d11.dll.
- Remove some unnecessary warning for better game mod experience.
- Transfer to VS2022 ,PlatformToolsetV143, Win10SDK latest.
- All my change code is commented with Nico: ,you can search Nico: in solution to find out what I have changed.

# Discord
You can send me feedback or ask question about 3Dmigoto source code in this discord channel:

Server invite link£ºhttps://discord.gg/JEcWVKr7wu 


# Acknowledgements
Without their original 3dmigoto repo the game mod version will be impossible.
Huge thanks to Chiri,DarkStarSword,bo3b and 3Dmigoto original author group.

Special thanks for GIMI&SRMI author:
SilentNightSound
