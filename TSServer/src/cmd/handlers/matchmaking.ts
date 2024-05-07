import addHandler from "#cmd/handlePacket";
import Ticket from "#matchmaking/ticket";

// data.req is checked in the validator
addHandler('match find', (c, data) => {
    if (!global.config.matchmaking_enabled)
        c.sendMatchDenied('matchmaking is disabled');

    let req = data.req;
    
    let res = c.matchMakingStart(req);
    if (typeof res === 'string') {
        c.sendMatchDenied(res);
    }
    else {
        c.sendMatchFinding(res as Ticket);
    }
});

addHandler('match stop', (c, data) => {
    c.matchMakingStop();
});