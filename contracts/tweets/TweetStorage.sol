pragma solidity >=0.4.22 <0.9.0;

import "../helpers/BaseStorage.sol";

contract TweetStorage is BaseStorage {
    mapping(uint256 => Tweet) public tweets;
    mapping(uint256 => uint256[]) public userTweetIds;
    uint256[] public tweetIds;

    struct Tweet {
        uint256 id;
        string text;
        uint256 userId;
        uint256 postedAt;
        string postHash;
    }

    uint256 latestTweetId = 0;

    function createTweet(
        uint256 _userId,
        string memory _text,
        string memory postHash
    ) public onlyController returns (uint256) {
        latestTweetId++;

        tweets[latestTweetId] = Tweet(
            latestTweetId,
            _text,
            _userId,
            block.timestamp,
            postHash
        );
        userTweetIds[_userId].push(latestTweetId);
        tweetIds.push(latestTweetId);

        return latestTweetId;
    }

    function getTweetIdsFromUser(uint256 _userId)
        public
        view
        returns (uint256[] memory)
    {
        return userTweetIds[_userId];
    }

    function getNumTweets() public view returns (uint256 _numTweets) {
        return tweetIds.length;
    }
}
