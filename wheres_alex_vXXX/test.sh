# The private key and address of the challenger - Alice.
# Swap these in when running transactions as the challenger.
# "private_key": "APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV",
# "address": "aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls"

# The private key and address of the opponent - Bob.
# Swap these in when running transactions as the opponent.
# "private_key": "APrivateKey1zkpALDDK4zAigs387emvnuxWXvGjFw2AmmYcQH7TBt8nhof"
# "address": "aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a"

# The private key and address of the game multisig.
# Swap these when running transactions from the game multisig.
# "private_key": "APrivateKey1zkp8pmTMT4FxG5qXZ9McEYDdY1G6YokY1BYzwoxTYJEKubF"
# "address": "aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6"


# Swap in the private key of the challenger -- Alice.
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkp9p8bttYsy3EuwiGrb4PXmrtjzZkpGvBCGVCgvpcwVjUV
" > .env

echo "
#       :::::::::  :::::::::   ::::::::  :::::::::   ::::::::   ::::::::  ::::::::::
#      :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:
#     +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+ +:+        +:+
#    +#++:++#+  +#++:++#:  +#+    +:+ +#++:++#+  +#+    +:+ +#++:++#++ +#++:++#
#   +#+        +#+    +#+ +#+    +#+ +#+        +#+    +#+        +#+ +#+
#  #+#        #+#    #+# #+#    #+# #+#        #+#    #+# #+#    #+# #+#
# ###        ###    ###  ########  ###         ########   ########  ##########
#       ::::::::      :::       :::   :::   ::::::::::
#     :+:    :+:   :+: :+:    :+:+: :+:+:  :+:
#    +:+         +:+   +:+  +:+ +:+:+ +:+ +:+
#   :#:        +#++:++#++: +#+  +:+  +#+ +#++:++#
#  +#+   +#+# +#+     +#+ +#+       +#+ +#+
# #+#    #+# #+#     #+# #+#       #+# #+#
# ########  ###     ### ###       ### ##########
"

# leo run add_player "{player_id: 0u8,team_id: 0u8,goalkeeper: 0u8,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8}"

leo run propose_game "{
        owner: aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls.private,
        amount: 500u64.private,
        ix: 0u32.private,
        _nonce: 5117772722354704202838157764917930913180509833961648133377098024993045952079group.public
    }" 100u64 aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo16hf8hfpwasnn9cf7k2c0dllc56nn7qt547qxgvgwu6pznw4trvqsx68kls aleo1r4pc6ufjvw050jhzrew3vqm2lvacdxfd4a5ckulau0vjc72qvc8sr0jg2a aleo1asu88azw3uqud282sll23wh3tvmvwjdz5vhvu2jwyrdwtgqn5qgqetuvr6 8062328565641143710315198539395259864274213782537700083868207132716559019626field 646976134778083579747150617209623060175268802563807996500102649727939562470field 7738966642647861988443742254957166327730088714215632067055062293849087980027field 501202936879316583063216806269060512965140130553350448375465909870676136661field 478560413032field sign1h04lnsl0t4aau8lzp06rzcm5eqrzr9ew63ljnw43v2nr7nkmsqqcx8cksna2ajwgk80rv0s7prrndw5k56sey3nrl487552lvaukuq8xe0cgu6x809qetnn35ufm3gl6ecyvtpgaavu9y5754j27utrwq8amruqyq2x6dvqs790yqsrctwmjnh3k7thslm0r9c3hpdvjrywpzts24xr 12345field "[{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8},{player_id: 0u8,team_id: 0u8,goalkeeper: false,attack: 0u8,defense: 0u8,speed: 0u8,power: 0u8,stamina: 0u8,technique: 0u8,goalkeeping: 0u8}]" 98765field
