
class Templar : Actor
{
	Default
	{
		Health 300;
		Painchance 100;
		Speed 8;
		Radius 20;
		Height 60;
		Mass 500;
		Monster;
		+NOBLOOD
		+SEESDAGGERS
		+NOSPLASHALERT
		MaxdropoffHeight 32;
		MinMissileChance 200;
		SeeSound "templar/sight";
		PainSound "templar/pain";
		DeathSound "templar/death";
		ActiveSound "templar/active";
		CrushPainSound "misc/pcrush";
		Tag "$TAG_TEMPLAR";
		HitObituary "$OB_TEMPLARHIT";
		Obituary "$OB_TEMPLAR";
		DropItem "EnergyPod";
	}

	States
	{
	Spawn:
		PGRD A 5 A_Look2;
		Loop;
		PGRD B 10;
		Loop;
		PGRD C 10;
		Loop;
		PGRD B 10 A_Wander;
		Loop;
	See:
		PGRD AABBCCDD 3 A_Chase;
		Loop;
	Melee:
		PGRD E 8 A_FaceTarget;
		PGRD F 8 A_CustomMeleeAttack(random[ReaverMelee](1,8)*3, "reaver/blade");
		Goto See;
	Missile:
		PGRD G 8 BRIGHT A_FaceTarget;
		PGRD H 8 BRIGHT A_TemplarAttack;
		Goto See;
	Pain:
		PGRD A 2;
		PGRD A 2 A_Pain;
		Goto See;
	Death:
		PGRD I 4 A_TossGib;
		PGRD J 4 A_Scream;
		PGRD K 4 A_TossGib;
		PGRD L 4 A_NoBlocking;
		PGRD MN 4;
		PGRD O 4 A_TossGib;
		PGRD PQRSTUVWXYZ[ 4;
		PGRD \ -1;
		Stop;
	}
	
	void A_TemplarAttack()
	{
		if (target != null)
		{
			A_PlaySound ("templar/shoot", CHAN_WEAPON);
			A_FaceTarget ();
			double pitch = AimLineAttack (angle, MISSILERANGE);

			for (int i = 0; i < 10; ++i)
			{
				int damage = random[Templar](1, 4) * 2;
				double ang = angle + random2[Templar]() * (11.25 / 256);
				LineAttack (ang, MISSILERANGE+64., pitch + random2[Templar]() * (7.097 / 256), damage, 'Hitscan', "MaulerPuff");
			}
		}
	}
}

