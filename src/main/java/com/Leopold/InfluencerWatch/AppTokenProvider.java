package com.Leopold.InfluencerWatch;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Instant;
import java.util.Date;
import java.util.Optional;

@Component
public class AppTokenProvider {

    private static final long EXPIRATION_TIME_SECONDS = 864_000_000;
    private static final String SECRET = "TwbMoIM4HzSmyr-Jsem_xGhZ";
    private static final String TOKEN_PREFIX = "Bearer";
    private static final String HEADER_STRING = "Authorization";

    public static void addAuthentication(HttpServletResponse res, String userId) {
        res.addHeader(HEADER_STRING, TOKEN_PREFIX + " " + getNewPerishableToken(userId));
    }

    private static String getNewPerishableToken(String userId) {
        return Jwts.builder()
                .setSubject(userId)
                .setExpiration(new Date(System.nanoTime() + EXPIRATION_TIME_SECONDS))
                .signWith(SignatureAlgorithm.HS256, SECRET)
                .compact();
    }

    public String getNewPerishableTokenFor(String userId) {
        return getNewPerishableToken(userId);
    }

    public static Optional<String> getUserFromToken(HttpServletRequest request) {
        final String token = request.getHeader(HEADER_STRING);

        if (token != null) {
            try {
                Claims body = Jwts.parser()
                        .setSigningKey(SECRET)
                        .parseClaimsJws(token.replace(TOKEN_PREFIX, ""))
                        .getBody();
                final Instant expiration = body.getExpiration().toInstant();

                if (expiration.isBefore(Instant.now())) {
                    return Optional.empty();
                }
                return Optional.of(body.getSubject());

            } catch (SignatureException e) {
                // invalid signature
            }
        }
        return Optional.empty();
    }
}