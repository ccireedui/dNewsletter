const fs = require('fs');
const path = require('path');
const hre = require("hardhat");

async function main() {
    const NewsNFT = await ethers.getContractFactory("NewsNFT");
    const newsNftContract = await NewsNFT.deploy();
    await newsNftContract.deployed();

    console.log("NewsNFT contract deployed to:", newsNftContract.address);

    const content = {
        "newsNftContract": newsNftContract.address,
    }
    createAddressJson(path.join(__dirname, '/../app/genAddresses.json'), JSON.stringify(content))

}

function createAddressJson(path, content) {
    try {
        fs.writeFileSync(path, content)
        console.log("Created Contract Address JSON")
    } catch (err) {
        console.error(err)
        return
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
