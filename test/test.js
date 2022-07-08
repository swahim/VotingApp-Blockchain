const { expect } = require("chai");

describe("Voting", function () {
  it("should register candidates", async () => {
    const Voting = await ethers.getContractFactory("Voting");
    const voting = await Voting.deploy();
    await voting.deployed();
    await voting.registerCandidates("Swahim Namdev", 19);
    expect(await voting.registeredCandidates([0]).candidateName, "Swahim Namdev");
  });

  it("should add verified candidates", async () => {
    const Voting = await ethers.getContractFactory("Voting");
    const voting = await Voting.deploy();
    await voting.deployed();
  })
});
