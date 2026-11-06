# NixOS Config

This is my personal NixOS Config, which I use for my personal machines.
The goal of this is to have all my system config in one place, so I can guarantee them to be identical setups because I switch between machines a lot. 
Reproducability is also the only reason I've made my entrypoint a flake, so the versions are locked as well as the config having to guarantee pure evaluation.
Otherwise I have not seen a point in using flakes at any other places, and can so far agree with this: [flakes are not real](https://jade.fyi/blog/flakes-arent-real/)
Since I'm still relatively new to nix and NixOS this repo also documents my learning path. 

## Secrets 
I Manage my secrets using agenix, which ecrypts them with age encryption, so I can just push them into my repo since they are only readable with my private keys.
